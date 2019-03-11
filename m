Return-Path: virtio-return-3271-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 17:00:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190311170035.7c7eb5c0.cohuck@redhat.com>
In-Reply-To: <20190311154950.29507-1-mst@redhat.com>
References: <20190311154950.29507-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH] signal start and end of structures
 consistently
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 11 Mar 2019 11:50:00 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Make sure all structs have the format:
> 
> struct X [
> ...
> ];

[] or {}?

(either will work, I guess)

> 
> VIRTIO-170
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex    | 11 +++++------
>  virtio-gpu.tex |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 4180296..f40d4fc 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5272,8 +5272,7 @@ The following commands are defined:
>  #define VIRTIO_SCSI_T_TMF_QUERY_TASK           6
>  #define VIRTIO_SCSI_T_TMF_QUERY_TASK_SET       7
>  
> -struct virtio_scsi_ctrl_tmf
> -{
> +struct virtio_scsi_ctrl_tmf {
>          // Device-readable part
>          le32 type;
>          le32 subtype;
> @@ -5281,7 +5280,7 @@ struct virtio_scsi_ctrl_tmf
>          le64 id;
>          // Device-writable part
>          u8   response;
> -}
> +};
>  
>  /* command-specific response values */
>  #define VIRTIO_SCSI_S_FUNCTION_COMPLETE        0
> @@ -5328,7 +5327,7 @@ struct virtio_scsi_ctrl_an {
>      // Device-writable part
>      le32 event_actual;
>      u8   response;
> -}
> +};
>  
>  #define VIRTIO_SCSI_EVT_ASYNC_OPERATIONAL_CHANGE  2
>  #define VIRTIO_SCSI_EVT_ASYNC_POWER_MGMT          4
> @@ -5363,7 +5362,7 @@ struct virtio_scsi_ctrl_an {
>          // Device-writable part
>          le32 event_actual;
>          u8   response;
> -}
> +};
>  \end{lstlisting}
>  
>    By sending this command, the driver asks the specified LUN to
> @@ -5415,7 +5414,7 @@ struct virtio_scsi_event {
>          le32 event;
>          u8  lun[8];
>          le32 reason;
> -}
> +};
>  \end{lstlisting}
>  
>  The devices sets bit 31 in \field{event} to report lost events
> diff --git a/virtio-gpu.tex b/virtio-gpu.tex
> index 0cf2209..992d4e6 100644
> --- a/virtio-gpu.tex
> +++ b/virtio-gpu.tex
> @@ -47,7 +47,7 @@ struct virtio_gpu_config {
>          le32 events_clear;
>          le32 num_scanouts;
>          le32 reserved;
> -}
> +};
>  \end{lstlisting}
>  
>  \subsubsection{Device configuration fields}


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

