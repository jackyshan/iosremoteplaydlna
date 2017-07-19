/*****************************************************************
 |
 |   Platinum - Miccro Media Controller
 |
 | Copyright (c) 2004-2010, Plutinosoft, LLC.
 | All rights reserved.
 | http://www.plutinosoft.com
 |
 | This program is free software; you can redistribute it and/or
 | modify it under the terms of the GNU General Public License
 | as published by the Free Software Foundation; either version 2
 | of the License, or (at your option) any later version.
 |
 | OEMs, ISVs, VARs and other distributors that combine and
 | distribute commercially licensed software with Platinum software
 | and do not wish to distribute the source code for the commercially
 | licensed software under version 2, or (at your option) any later
 | version, of the GNU General Public License (the "GPL") must enter
 | into a commercial license agreement with Plutinosoft, LLC.
 | licensing@plutinosoft.com
 |
 | This program is distributed in the hope that it will be useful,
 | but WITHOUT ANY WARRANTY; without even the implied warranty of
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 | GNU General Public License for more details.
 |
 | You should have received a copy of the GNU General Public License
 | along with this program; see the file LICENSE.txt. If not, write to
 | the Free Software Foundation, Inc.,
 | 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 | http://www.gnu.org/licenses/gpl-2.0.html
 |
 ****************************************************************/

/*----------------------------------------------------------------------
 |   includes
 +---------------------------------------------------------------------*/

#ifndef PltMicroMediaController_hpp
#define PltMicroMediaController_hpp

#import <Platinum/PltLeaks.h>
#import <Platinum/PltDownloader.h>
#import <Platinum/Platinum.h>
#import <Platinum/PltMediaServer.h>
#import <Platinum/PltSyncMediaBrowser.h>
#import <Platinum/PltMediaController.h>
#import <Platinum/Neptune.h>

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#import "ZM_DMRControl.h"

/*----------------------------------------------------------------------
 |   definitions
 +---------------------------------------------------------------------*/
typedef NPT_Map<NPT_String, NPT_String>              PLT_StringMap;
typedef NPT_Lock<PLT_StringMap>                      PLT_LockStringMap;
typedef NPT_Map<NPT_String, NPT_String>::Entry       PLT_StringMapEntry;

/*----------------------------------------------------------------------
 |   PLT_MediaItemIDFinder
 +---------------------------------------------------------------------*/
class PLT_MediaItemIDFinder
{
public:
    // methods
    PLT_MediaItemIDFinder(const char* object_id) : m_ObjectID(object_id) {}
    
    bool operator()(const PLT_MediaObject* const & item) const {
        return item->m_ObjectID.Compare(m_ObjectID, true) ? false : true;
    }
    
private:
    // members
    NPT_String m_ObjectID;
};

/*----------------------------------------------------------------------
 |   PLT_MicroMediaController
 +---------------------------------------------------------------------*/
class PLT_MicroMediaController : public PLT_SyncMediaBrowser,
public PLT_MediaController,
public PLT_MediaControllerDelegate
{
public:
    
    PLT_MicroMediaController(PLT_CtrlPointReference& ctrlPoint,ZM_DMRControl * delegateWrapper);
    virtual ~PLT_MicroMediaController();
        
    // PLT_MediaBrowserDelegate methods
    bool OnMSAdded(PLT_DeviceDataReference& device);
    void OnMSRemoved(PLT_DeviceDataReference& device);
    
    // PLT_MediaControllerDelegate methods
    bool OnMRAdded(PLT_DeviceDataReference& device);
    void OnMRRemoved(PLT_DeviceDataReference& device);
    void OnMRStateVariablesChanged(PLT_Service* /* service */,
                                   NPT_List<PLT_StateVariable*>* /* vars */);
    
    // AVTransport
    void OnGetCurrentTransportActionsResult(
                                            NPT_Result               /* res */,
                                            PLT_DeviceDataReference& /* device */,
                                            PLT_StringList*          /* actions */,
                                            void*                    /* userdata */) ;
    
#if 0
    void OnGetDeviceCapabilitiesResult(
                                       NPT_Result               /* res */,
                                       PLT_DeviceDataReference& /* device */,
                                       PLT_DeviceCapabilities*  /* capabilities */,
                                       void*                    /* userdata */) ;
#endif

    
#if 0
    
    void OnGetMediaInfoResult(
                              NPT_Result               /* res */,
                              PLT_DeviceDataReference& /* device */,
                              PLT_MediaInfo*           /* info */,
                              void*                    /* userdata */) ;
#endif
    
#if 0
    
    void OnGetPositionInfoResult(
                                 NPT_Result               /* res */,
                                 PLT_DeviceDataReference& /* device */,
                                 PLT_PositionInfo*        /* info */,
                                 void*                    /* userdata */) ;
#endif
    
    void OnGetTransportInfoResult(
                                  NPT_Result               /* res */,
                                  PLT_DeviceDataReference& /* device */,
                                  PLT_TransportInfo*       /* info */,
                                  void*                    /* userdata */) ;

#if 0
    
    void OnGetTransportSettingsResult(
                                      NPT_Result               /* res */,
                                      PLT_DeviceDataReference& /* device */,
                                      PLT_TransportSettings*   /* settings */,
                                      void*                    /* userdata */) ;
#endif
    
    
    void OnNextResult(
                      NPT_Result               /* res */,
                      PLT_DeviceDataReference& /* device */,
                      void*                    /* userdata */) ;
    
    void OnPauseResult(
                       NPT_Result               /* res */,
                       PLT_DeviceDataReference& /* device */,
                       void*                    /* userdata */) ;
    
    void OnPlayResult(
                      NPT_Result               /* res */,
                      PLT_DeviceDataReference& /* device */,
                      void*                    /* userdata */) ;
    
    void OnPreviousResult(
                          NPT_Result               /* res */,
                          PLT_DeviceDataReference& /* device */,
                          void*                    /* userdata */) ;
#if 0
    
    void OnSeekResult(
                      NPT_Result               /* res */,
                      PLT_DeviceDataReference& /* device */,
                      void*                    /* userdata */) ;
#endif
    
    
    void OnSetAVTransportURIResult(
                                   NPT_Result               /* res */,
                                   PLT_DeviceDataReference& /* device */,
                                   void*                    /* userdata */) ;

#if 0
    
    void OnSetPlayModeResult(
                             NPT_Result               /* res */,
                             PLT_DeviceDataReference& /* device */,
                             void*                    /* userdata */) ;
#endif
    
    void OnStopResult(
                      NPT_Result               /* res */,
                      PLT_DeviceDataReference& /* device */,
                      void*                    /* userdata */) ;
    
    // ConnectionManager
//    void OnGetCurrentConnectionIDsResult(
//                                         NPT_Result               /* res */,
//                                         PLT_DeviceDataReference& /* device */,
//                                         PLT_StringList*          /* ids */,
//                                         void*                    /* userdata */) ;
//    
//    void OnGetCurrentConnectionInfoResult(
//                                          NPT_Result               /* res */,
//                                          PLT_DeviceDataReference& /* device */,
//                                          PLT_ConnectionInfo*      /* info */,
//                                          void*                    /* userdata */) ;

#if 0
    
    void OnGetProtocolInfoResult(
                                 NPT_Result               /* res */,
                                 PLT_DeviceDataReference& /* device */,
                                 PLT_StringList*          /* sources */,
                                 PLT_StringList*          /* sinks */,
                                 void*                    /* userdata */) ;
#endif
    
    // RenderingControl
    
#if 0
    void OnSetMuteResult(
                         NPT_Result               /* res */,
                         PLT_DeviceDataReference& /* device */,
                         void*                    /* userdata */) ;
    
    void OnGetMuteResult(
                         NPT_Result               /* res */,
                         PLT_DeviceDataReference& /* device */,
                         const char*              /* channel */,
                         bool                     /* mute */,
                         void*                    /* userdata */) ;
    
#endif
    
    void OnSetVolumeResult(
                           NPT_Result               /* res */,
                           PLT_DeviceDataReference& /* device */,
                           void*                    /* userdata */) ;
    
    void OnGetVolumeResult(
                           NPT_Result               /* res */,
                           PLT_DeviceDataReference& /* device */,
                           const char*              /* channel */,
                           NPT_UInt32				 /* volume */,
                           void*                    /* userdata */) ;

public:
    
    const PLT_StringMap getMediaServersNameTable();
    const PLT_StringMap getMediaRenderersNameTable();
    
    void    chooseMeidaServer(NPT_String chosenUUID);
    void    chooseMediaRenderer(NPT_String chosenUUID);
    
    PLT_DeviceDataReference getCurrentMediaServer();
    PLT_DeviceDataReference getCurrentMediaRenderer();
    
    void    setRendererMute();
    void    getRendererMute();
    void    setRendererUnMute();
    void    setRendererVolume(int volume);
    void    getRendererVolume();
    void    sendSeekCommand(const char* command);
    
    void    setRendererPlay();
    void    setRendererPause();
    void    setRendererStop();
    void    setRendererNext();
    void    setRendererPrevious();
    void    setRendererAVTransportURI(const char *uriStr, const char *metaData);
    bool    canRendererSetNextURI();
    void    setRendererNextAVTransportURI(const char *nextUriStr);
    
    void    setRendererPlayMode(const char *new_play_mode);
    void    getRendererCurrentTransportActions();
    void    getRendererDeviceCapabilities();
    void    getRendererProtocolInfo();
    
    void    getRendererMediaInfo();
    void    getRendererPositionInfo();
    void    getRendererTransportInfo();
    void    getRendererTransportSettings();
    
private:
    
    PLT_DeviceDataReference ChooseDevice(const NPT_Lock<PLT_DeviceMap>& deviceList, NPT_String chosenUUID);
    
    void        GetCurMediaServer(PLT_DeviceDataReference& server);
    void        GetCurMediaRenderer(PLT_DeviceDataReference& renderer);
    
    const char* ChooseIDFromTable(PLT_StringMap& table);
    void        PopDirectoryStackToRoot(void);
    NPT_Result  DoBrowse(const char* object_id = NULL, bool metdata = false);

    // Command Handlers
    void    HandleCmd_scan(const char* ip);

    void    HandleCmd_ls();
    void    HandleCmd_info();
    void    HandleCmd_cd(const char* command);
    void    HandleCmd_cdup();
    void    HandleCmd_pwd();

    void    HandleCmd_download();
    
private:
    
    /* 代理对象 */
    ZM_DMRControl * m_Target;
    
    /* Tables of known devices on the network.  These are updated via the
     * OnMSAddedRemoved and OnMRAddedRemoved callbacks.  Note that you should first lock
     * before accessing them using the NPT_Map::Lock function.
     */
    NPT_Lock<PLT_DeviceMap> m_MediaServers;
    NPT_Lock<PLT_DeviceMap> m_MediaRenderers;

    /* Currently selected media server as well as
     * a lock.  If you ever want to hold both the m_CurMediaRendererLock lock and the
     * m_CurMediaServerLock lock, make sure you grab the server lock first.
     */
    PLT_DeviceDataReference m_CurMediaServer;
    NPT_Mutex               m_CurMediaServerLock;
    
    /* Currently selected media renderer as well as
     * a lock.  If you ever want to hold both the m_CurMediaRendererLock lock and the
     * m_CurMediaServerLock lock, make sure you grab the server lock first.
     */
    PLT_DeviceDataReference m_CurMediaRenderer;
    NPT_Mutex               m_CurMediaRendererLock;
    
    /* Most recent results from a browse request.  The results come back in a
     * callback instead of being returned to the calling function, so this
     * variable is necessary in order to give the results back to the calling
     * function.
     */
    PLT_MediaObjectListReference m_MostRecentBrowseResults;
    
    /* When browsing through the tree on a media server, this is the stack
     * symbolizing the current position in the tree.  The contents of the
     * stack are the object ID's of the nodes.  Note that the object id: "0" should
     * always be at the bottom of the stack.
     */
    NPT_Stack<NPT_String> m_CurBrowseDirectoryStack;
    
    /* Semaphore on which to block when waiting for a response from over
     * the network
     */
    NPT_SharedVariable m_CallbackResponseSemaphore;
    
    /* Task Manager managing download tasks */
    PLT_TaskManager m_DownloadTaskManager;
};


#endif /* PltMicroMediaController_hpp */
