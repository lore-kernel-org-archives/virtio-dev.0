Return-Path: <virtio-dev-return-12038-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C95C7618D
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:17:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0FB1842BC8
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:17:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0870C9865D8
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 07:17:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F31979865C8; Thu,  6 Apr 2023 07:17:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0C759865C1;
	Thu,  6 Apr 2023 07:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="341397898"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341397898"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="756281318"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="756281318"
Message-ID: <36570365-2355-6924-3fdb-1a94b7a3e902@linux.intel.com>
Date: Thu, 6 Apr 2023 15:17:27 +0800
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
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
In-Reply-To: <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v11 04/10] admin: introduce virtio admin
 virtqueues



On 4/3/2023 11:03 PM, Michael S. Tsirkin wrote:
> The admin virtqueues will be the first interface used to issue admin commands.
>
> Currently the virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on:
> virtio-net, virtio-scsi, etc all have existing control virtqueues. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
>
> Keeping the device-specific virtqueue separate from the admin virtqueue
> is simpler and has fewer potential problems. I don't think creating
> common infrastructure for device-specific control virtqueues across
> device types worthwhile or within the scope of this patch series.
>
> To support this requirement in a more generic way, this patch introduces
> a new admin virtqueue interface.
> The admin virtqueue can be seen as the virtqueue analog to a transport.
> The admin queue thus does nothing device type-specific (net, scsi, etc)
> and instead focuses on transporting the admin commands.
>
> We also support more than one admin virtqueue, for QoS and
> scalability requirements.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
> explain ordering of commands as suggested by Stefan
> dropped Max's S.O.B
> reword commit log as suggested by David
> minor wording fixes suggested by David
> ---
>   admin.tex   | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   content.tex |  7 +++--
>   2 files changed, 80 insertions(+), 2 deletions(-)
>
> diff --git a/admin.tex b/admin.tex
> index c869a1a..f201bcd 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -182,3 +182,78 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   \field{command_specific_data} and \field{command_specific_result}
>   depends on these structures and is described separately or is
>   implicit in the structure description.
> +
> +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> +
> +An administration virtqueue of an owner device is used to submit
> +group administration commands. An owner device can have more
> +than one administration virtqueue.
> +
> +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> +or more adminstration virtqueues. The number and locations of the
> +administration virtqueues are exposed by the owner device in a transport
> +specific manner.
> +
> +The driver queues requests to an arbitrary administration
> +virtqueue, and they are used by the device on that same
> +virtqueue. It is the responsibility of the driver to ensure
> +strict request ordering for commands, because they will be
> +consumed with no order constraints.  For example, if consistency
> +is required then the driver can wait for the processing of a
> +first command by the device to be completed before submitting
> +another command depending on the first one.
> +
> +Administration virtqueues are used as follows:
> +\begin{itemize}
> +\item The driver submits the command using the \field{struct virtio_admin_cmd}
> +structure using a buffer consisting of two parts: a device-readable one followed by a
> +device-writable one.
> +\item the device-readable part includes fields from \field{opcode}
> +through \field{command_specific_data}.
> +\item the device-writeable buffer includes fields from \field{status}
> +through \field{command_specific_result} inclusive.
> +\end{itemize}
> +
> +For each command, this specification describes a distinct
> +format structure used for \field{command_specific_data} and
> +\field{command_specific_result}, the length of these fields
> +depends on the command.
> +
> +However, to ensure forward compatibility
> +\begin{itemize}
> +\item drivers are allowed to submit buffers that are longer
> +than the device expects
> +(that is, longer than the length of
> +\field{opcode} through \field{command_specific_data}).
> +This allows the driver to maintain
> +a single format structure even if some structure fields are
> +unused by the device.
> +\item drivers are allowed to submit buffers that are shorter
> +than what the device expects
> +(that is, shorter than the length of \field{status} through
> +\field{command_specific_result}). This allows the device to maintain
> +a single format structure even if some structure fields are
> +unused by the driver.
> +\end{itemize}
> +
> +The device compares the length of each part (device-readable and
> +device-writeable) of the buffer as submitted by driver to what it
> +expects and then silently truncates the structures to either the
> +length submitted by the driver, or the length described in this
> +specification, whichever is shorter.  The device silently ignores
> +any data falling outside the shorter of the two lengths. Any
> +missing fields are interpreted as set to zero.
> +
> +Similarly, the driver compares the used buffer length
> +of the buffer to what it expects and then silently
> +truncates the structure to the used buffer length.
> +The driver silently ignores any data falling outside
> +the used buffer length reported by the device.  Any missing
> +fields are interpreted as set to zero.
> +
> +This simplifies driver and device implementations since the
> +driver/device can simply maintain a single large structure (such
> +as a C structure) for a command and its result. As new versions
> +of the specification are designed, new fields can be added to the
> +tail of a structure, with the driver/device using the full
> +structure without concern for versioning.
> diff --git a/content.tex b/content.tex
> index 04592fb..2eb15fa 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>   \begin{description}
>   \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>   
> -\item[24 to 40] Feature bits reserved for extensions to the queue and
> +\item[24 to 41] Feature bits reserved for extensions to the queue and
>     feature negotiation mechanisms
>   
> -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>   \end{description}
>   
>   \begin{note}
> @@ -7684,6 +7684,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>     that the driver can reset a queue individually.
>     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>   
> +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
> +  administration virtqueues.
> +
>   \end{description}
>   
>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

