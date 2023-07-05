Return-Path: <virtio-dev-return-13231-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136C7EB64DD
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:24:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4743F4256A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:24:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 295E5986722
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:24:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0EDB1986712; Wed,  5 Jul 2023 10:24:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE6B7986717
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Jul 2023 10:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: CTjl5kVrPDWFYMgD5ObfEw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com, david.edmondson@oracle.com
Cc: virtio-dev@lists.oasis-open.org, sburla@marvell.com,
 jasowang@redhat.com, yishaih@nvidia.com, maorg@nvidia.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230704233724.22394-4-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-4-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 05 Jul 2023 12:24:15 +0200
Message-ID: <87fs623bcg.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v9 3/4] admin: Add group member legacy register access
 commands

On Wed, Jul 05 2023, Parav Pandit <parav@nvidia.com> wrote:

> diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
> new file mode 100644
> index 0000000..09001d5
> --- /dev/null
> +++ b/admin-cmds-legacy-interface.tex
> @@ -0,0 +1,205 @@
> +\subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
> +administration commands / Legacy Interface}
> +
> +In some systems, there is a need to support utilizing the legacy driver with
> +the device that do not directly support the legacy interface. In such scenarios,

Maybe better:

"In some systems, there is a need to support utilizing legacy drivers with
devices that do not directly support the legacy interface."

?

> +a group owner device can provide the legacy interface functionality for the
> +group member devices. The driver of an owner device can then access the legacy
> +interface of a member device on behalf of the legacy member device driver.

(...)

> +\paragraph{Legacy Driver Notification Query}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Driver Notifications Query}
> +
> +Even though the driver notifications can be communicated through the
> +administration command, if the group owner device or group member device
> +supports such notifications using a memory-mapped operation or I/O operation,
> +they are sent to the device by accessing such a notification region using 
> +a memory or an I/O operation.

I find this sentence confusing, probably because it is too
complex... what about

"If the group owner device or the group member device support driver
notifications via a memory-mapped operation or I/O operation, these
notifications are sent to the device via accessing such a notification
region using a memory or I/O operation {in addition to|instead of}
communicating the notifications through the admistration command."

(I'm not sure whether it is either or both.)

> +
> +A group owner device optionally support querying driver notifications region

"can optionally support" ?

> +using VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command.
> +
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
> +This command does not use \field{command_specific_data}.
> +
> +When command completes successfully, \field{command_specific_result}

"the command"

> +uses following structure:


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

