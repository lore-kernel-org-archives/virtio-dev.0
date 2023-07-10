Return-Path: <virtio-dev-return-13327-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703AAEB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 09:37:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D07F32A82D
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 09:37:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4223986491
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 09:37:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B8056983FEA; Mon, 10 Jul 2023 09:37:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A72DB98640D
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Jul 2023 09:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zzwiSrC3OlCI_41gvnks8g-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com, david.edmondson@oracle.com
Cc: virtio-dev@lists.oasis-open.org, sburla@marvell.com,
 jasowang@redhat.com, yishaih@nvidia.com, maorg@nvidia.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230707153019.147039-1-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230707153019.147039-1-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 10 Jul 2023 11:37:49 +0200
Message-ID: <87pm50yumq.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] [PATCH v13] admin: Add group member legacy
 register access commands

On Fri, Jul 07 2023, Parav Pandit <parav@nvidia.com> wrote:

(...)

> +When the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command, the group

s/supports/supports the/

> +owner device hardwires VF BAR0 to zero in the SR-IOV Extended capability.

(...)

> +\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
> +
> +A device MUST either support all of, or none of
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,

s/For/For the/

> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands,
> +the device MUST decode and encode (respectively) the value of the
> +\field{data} using the little-endian format.
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and

s/For/For the/

> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands, 
> +the device MUST fail the command when the value of the
> +\field{offset} and the length of the \field{data} does not refer to a

"do not", I think?

> +single field or is not completely within the virtio common configuration
> +excluding the device-specific configuration.
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and

s/For/For the/

> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands,
> +the device MUST fail the command when the value of the
> +\field{offset} and the length of the \field{data} does not refer to a

"do not"?

> +single field or is not completely within the virtio device-specific
> +configuration.
> +
> +The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE MUST have the same effect
> +as writing into the virtio common configuration structure through the legacy
> +interface.
> +
> +The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ MUST have the same effect as
> +reading from the virtio common configuration structure through the legacy
> +interface.
> +
> +The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE MUST have the same effect as
> +writing into the virtio device-specific configuration through the legacy
> +interface.
> +
> +The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ MUST have the same effect as
> +reading from the virtio device-specific configuration through the legacy
> +interface.
> +
> +For the SR-IOV group type, when the owner device supports
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> +commands,
> +\begin{itemize}
> +\item the owner device and the group member device SHOULD follow the rules
> +for the PCI Revision ID and Subsystem Device ID of the non-transitional devices
> +documented in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
> +
> +\item the owner device SHOULD follow the rules for the PCI Device ID of the non-transitional
> +devices documented in section
> +\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
> +
> +\item any driver notification received by the device at any of the notification
> +address supplied in the command result of
> +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO MUST function as if the device received
> +the notification through VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> +command at an offset \field{offset} matching \field{Queue Notify}.
> +\end{itemize}
> +
> +If the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command,

s/support/supports the/

> +\begin{itemize}
> +\item the device MUST also support all of VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
> +
> +\item in the command result of VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, the last
> +\field{struct virtio_pci_legacy_notify_info} entry MUST have \field{flags} of
> +zero.
> +
> +\item in the command result of VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, valid
> +entries MUST have a \field{bar} which is not hardwired to zero.
> +
> +\item in the command result of VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, valid
> +entries MUST have an \field{offset} aligned to 2-byte.
> +
> +\item the device MAY support VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO with entries
> +of the owner device or the member device or both of them.
> +
> +\item for the SR-IOV group type, the group owner device MUST hardwire VF BAR0
> +to zero in the SR-IOV Extended capability.
> +\end{itemize}
> +
> +\drivernormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,

s/For/For the/

> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands,
> +the driver MUST encode and decode (respectively) the value of the \field{data}
> +using the little-endian format.
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and

s/For/For the/

> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands,
> +the driver SHOULD set \field{offset} and the length of the \field{data}
> +to refer to a single field within the virtio common configuration structure
> +excluding the device-specific configuration.
> +
> +For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands,
> +the driver SHOULD set \field{offset} and the length of the \field{data}
> +to refer to a single field within device specific configuration.
> +
> +If VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command is supported, the driver

s/If/If the/

> +SHOULD use the notification address to send all driver notifications to the
> +device.

(...)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

