#include "modelsmanager.h"

#include <QtCore>
#include <QObject>
#include <QQuickView>
#include <QtQml>
#include "src/settings.h"

ModelsManager::ModelsManager() :
    m_connection(this),
    m_stationListModel(nullptr),
    m_sensorListModel(nullptr),
    m_provinceListModel(nullptr)
{
    QObject::connect(&m_timer, &QTimer::timeout, [this](){
        updateModels();
    });
}

ModelsManager::~ModelsManager()
{
    deleteModels();
}

void ModelsManager::createModels()
{
    m_stationListModel = new StationListModel();
    m_provinceListModel = new ProvinceListModel();
    m_sensorListModel = new SensorListModel();

    m_provinceListModel->setModels(this);
    m_stationListModel->setModels(this);

    m_sensorListModel->setConnection(&m_connection);
    m_stationListModel->setConnection(&m_connection);
}

void ModelsManager::deleteModels()
{
    delete m_stationListModel;
    delete m_provinceListModel;
    delete m_sensorListModel;
}

void ModelsManager::bindToQml(QQuickView * view)
{
    qmlRegisterType<ProvinceListModel>("ProvinceListModel", 1, 0, "ProvinceListModel");

    StationListProxyModel::bindToQml();
    StationListModel::bindToQml(view);

    view->rootContext()->setContextProperty(QStringLiteral("stationListModel"), m_stationListModel);
    view->rootContext()->setContextProperty(QStringLiteral("provinceListModel"), m_provinceListModel);
    view->rootContext()->setContextProperty(QStringLiteral("sensorListModel"), m_sensorListModel);
}

void ModelsManager::loadSettings()
{
    Settings * settings = qobject_cast<Settings*>(Settings::instance(nullptr, nullptr));

    StationListPtr stationList = settings->favouriteStations();

    m_stationListModel->setStationList(std::move(stationList));
    m_stationListModel->getIndexForFavourites();

    m_timer.start(60 * 60 * 1000);
}

ProvinceListModel *ModelsManager::provinceListModel() const
{
    return m_provinceListModel;
}

void ModelsManager::updateModels()
{
    m_stationListModel->getIndexForFavourites();
}

SensorListModel *ModelsManager::sensorListModel() const
{
    return m_sensorListModel;
}

StationListModel *ModelsManager::stationListModel() const
{
    return m_stationListModel;
}