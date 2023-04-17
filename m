Return-Path: <virtio-dev-return-12246-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2146C77B77
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:42:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E32B32A82E
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:42:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE9B09863C7
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:42:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AE90F9862EE; Mon, 17 Apr 2023 03:42:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B23C986312;
	Mon, 17 Apr 2023 03:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Mon, 17 Apr 2023 05:41:49 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230417054149.5d7f62e8.pasic@linux.ibm.com>
In-Reply-To: <20230411192341.751841-4-parav@nvidia.com>
References: <20230411192341.751841-1-parav@nvidia.com>
	<20230411192341.751841-4-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NgtSdhFmo1DCch_IdNqIZQEghHclyntq
X-Proofpoint-ORIG-GUID: LUMYa4XLc8OQFfQ7dVFVN04gu6B6a-dJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-16_16,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170031
Subject: Re: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names

On Tue, 11 Apr 2023 22:23:33 +0300
Parav Pandit <parav@nvidia.com> wrote:

> Currently queue_notify_data register indicates the device
> internal queue notification content. This register is
> meaningful only when feature bit VIRTIO_F_NOTIF_CONFIG_DATA is
> negotiated.
> 
> However, above register name often get confusing association with
> very similar feature bit VIRTIO_F_NOTIFICATION_DATA.
> 
> When VIRTIO_F_NOTIFICATION_DATA feature bit is negotiated,
> notification really involves sending additional queue progress
> related information (not queue identifier or index).
> 
> Hence
> 1. to avoid any misunderstanding and association of
> queue_notify_data with similar name VIRTIO_F_NOTIFICATION_DATA,
> 
> and
> 2. to reflect that queue_notify_data is the actual device
> internal virtqueue identifier/index/data/cookie,
> 
> a. rename queue_notify_data to queue_notify_config_data.
> queue_notify_config_data.
> 
> b. rename ambiguous vqn to a union of vq_index and vq_config_data
> 
> c. The driver notification section assumes that queue notification contains
> vq index always. CONFIG_DATA feature bit introduction missed to
> update the driver notification section. Hence, correct it.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> changelog:
> v12->v13:
> - replace _id with _config_data
> - dropped vq identifier
> - dropped the idea of union as description is for config data feature
> v11->v12:
> - new patch
> ---
>  content.tex        | 11 ++++++++---
>  notifications-be.c |  2 +-
>  notifications-le.c |  2 +-
>  transport-pci.tex  | 26 ++++++++++++++++----------
>  4 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index e79d722..601c069 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -404,8 +404,12 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  notification to the device.
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> -this notification involves sending the
> -virtqueue index to the device (method depending on the transport).
> +this notification contains either virtqueue
> +index if VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated or device
> +supplied virtqueue notification data if
> +VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
> +
> +A method to supply such virtqueue notification data is transport specific.
>  
>  However, some devices benefit from the ability to find out the
>  amount of available data in the queue without accessing the virtqueue in memory:
> @@ -416,7 +420,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  the following information:
>  
>  \begin{description}
> -\item [vqn] VQ number to be notified.
> +\item [vq_index_config_data] either virtqueue index or device supplied
> +      queue notification config data corresponding to a virtqueue.
>  \item [next_off] Offset
>        within the ring where the next available ring entry
>        will be written.
> diff --git a/notifications-be.c b/notifications-be.c
> index 5be947e..02f0624 100644
> --- a/notifications-be.c
> +++ b/notifications-be.c
> @@ -1,5 +1,5 @@
>  be32 {
> -	vqn : 16;
> +	vq_config_data: 16; /* previously known as vqn */
>  	next_off : 15;
>  	next_wrap : 1;
>  };
> diff --git a/notifications-le.c b/notifications-le.c
> index fe51267..f73c6a5 100644
> --- a/notifications-le.c
> +++ b/notifications-le.c
> @@ -1,5 +1,5 @@
>  le32 {
> -	vqn : 16;
> +	vq_config_data: 16; /* previously known as vqn */

Is this where the union was supposed to go? I.e.
something like:

        union {
		le16 vq_config_data;
		le16 vq_index;
	} vq_index_config_data;

(You said  in the v12 disussion in MID
<PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
that you are going to change vqn to the union of vq_config_data and
vq_index, although vq_notif_config_data might be preferable).

Or did you mean to do 

+	vq_index_config_data: 16; /* previously known as vqn */

Of course, this has an impact on the rest of the text...

>  	next_off : 15;
>  	next_wrap : 1;
>  };
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 5d98467..53c8ee6 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -319,7 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> -        le16 queue_notify_data;         /* read-only for driver */
> +        le16 queue_notify_config_data;  /* read-only for driver */
>          le16 queue_reset;               /* read-write */
>  };
>  \end{lstlisting}
> @@ -388,17 +388,21 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>  
> -\item[\field{queue_notify_data}]
> +\item[\field{queue_notify_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
> -        The driver will use this value to put it in the 'virtqueue number' field
> -        in the available buffer notification structure.
> +        The driver will use this value when driver sends available buffer
> +        notification to the device.
>          See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>          \begin{note}
>          This field provides the device with flexibility to determine how virtqueues
>          will be referred to in available buffer notifications.
> -        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
> -        may benefit from providing another value, for example an internal virtqueue
> -        identifier, or an internal offset related to the virtqueue number.
> +        In a trivial case the device can set \field{queue_notify_config_data} to
> +        virtqueue index. Some devices may benefit from providing another value,
> +        for example an internal virtqueue identifier, or an internal offset
> +        related to the virtqueue index.
> +        \end{note}
> +        \begin{note}
> +        This field is previously known as queue_notify_data.
>          \end{note}
>  
>  \item[\field{queue_reset}]
> @@ -468,7 +472,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  
>  \drivernormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
>  
> -The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \field{config_generation}, \field{queue_notify_off} or \field{queue_notify_data}.
> +The driver MUST NOT write to \field{device_feature}, \field{num_queues},
> +\field{config_generation}, \field{queue_notify_off} or
> +\field{queue_notify_config_data}.
>  
>  If VIRTIO_F_RING_PACKED has been negotiated,
>  the driver MUST NOT write the value 0 to \field{queue_size}.

> @@ -1053,9 +1059,9 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
>  \begin{itemize}
>  \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
> -\field{queue_notify_data} value instead of the virtqueue index.
> +\field{queue_notify_id} value instead of the virtqueue index.
>  \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
> -\field{vqn} field to the \field{queue_notify_data} value.
> +\field{vq_notify_id} field to the \field{queue_notify_id} value.

Seems you did not catch these with the s/_id/_config_data/. By doing the
replace one would get queue_notify_config_data, vq_notify_config_data
and queue_notify_config_data respectively.

But that still does not seem right, and the right answer depends on
to what do we rename \field{vqn}.

Regards,
Halil 

>  \end{itemize}
>  
>  \subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

