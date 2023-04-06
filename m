Return-Path: <virtio-dev-return-12040-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831FCC7618D
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:18:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E97D042A69
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:18:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1A689865EF
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:18:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D7D579865B7; Thu,  6 Apr 2023 07:18:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6D949865C1;
	Thu,  6 Apr 2023 07:18:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="341397984"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341397984"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="756281466"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="756281466"
Message-ID: <6cef501a-daa4-510c-b99a-6c0d03e208ed@intel.com>
Date: Thu, 6 Apr 2023 15:17:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <fbf6f659974884f7430ec7ef68028305d7acee0c.1680533760.git.mst@redhat.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <fbf6f659974884f7430ec7ef68028305d7acee0c.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio] [PATCH v11 05/10] pci: add admin vq registers to virtio
 over pci



On 4/3/2023 11:03 PM, Michael S. Tsirkin wrote:
> Add new registers to the PCI common configuration structure.
>
> These registers will be used for querying the indices of the admin
> virtqueues of the owner device. To configure, reset or enable the admin
> virtqueues, the driver should follow existing queue configuration/setup
> sequence.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
> dropped Max's S.O.B
> make queue_num not 0 based
> ---
>   content.tex | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 2eb15fa..5057df2 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -948,6 +948,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>           le64 queue_device;              /* read-write */
>           le16 queue_notify_data;         /* read-only for driver */
>           le16 queue_reset;               /* read-write */
> +
> +        /* About the administration virtqueue. */
> +        le16 admin_queue_index;         /* read-only for driver */
> +        le16 admin_queue_num;         /* read-only for driver */
>   };
>   \end{lstlisting}
>   
> @@ -1033,6 +1037,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>           This field exists only if VIRTIO_F_RING_RESET has been
>           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>   
> +\item[\field{admin_queue_index}]
> +        The device uses this to report the index of the first administration virtqueue.
> +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> +\item[\field{admin_queue_num}]
> +	The device uses this to report the number of the
> +	supported administration virtqueues.
> +	Virtqueues with index
> +	between \field{admin_queue_index} and (\field{admin_queue_index} +
> +	\field{admin_queue_num} - 1) inclusive serve as administration
> +	virtqueues.
> +	The value 0 indicates no supported administration virtqueues.
> +	This field is valid only if VIRTIO_F_ADMIN_VQ has been
> +	negotiated.
>   \end{description}
>   
>   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> @@ -1119,6 +1136,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>   were used before the queue reset.
>   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>   
> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> +configures any administration virtqueues, the driver MUST
> +configure the administration virtqueues using the index
> +in the range \field{admin_queue_index} to
> +\field{admin_queue_index} + \field{admin_queue_num} - 1 inclusive.
> +The driver MAY configure less administration virtqueues than
> +supported by the device.
> +
>   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>   
>   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> @@ -7686,6 +7711,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>   
>     \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
>     administration virtqueues.
> +  At the moment this feature is only supported for devices using
> +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> +	  as the transport and is reserved for future use for
> +	  devices using other transports (see
> +	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
> +	and
> +	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
> +	handling features reserved for future use.
>   
>   \end{description}
>   
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

