Return-Path: <virtio-dev-return-10611-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63F7A9865D5
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Jan 2023 10:20:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230112212254.763783-1-parav@nvidia.com>
References: <20230112212254.763783-1-parav@nvidia.com>
Date: Fri, 13 Jan 2023 11:19:52 +0100
Message-ID: <87bkn2ohx3.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v4 00/20] Split device spec to its
 individual files
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, david@redhat.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 12 2023, Parav Pandit <parav@nvidia.com> wrote:

> Relatively several of the recent device specifications are maintained
> in their own specification file. Such separate files enables better
> maintenance of the specification overall.
> However, several of the initial virtio device specifications
> are located in single file.
>
> Hence, split them into their individual files.
>
> Additionally, each device's driver and device conformance is
> present in one giant conformance file all together.
>
> As Michael suggest's move this device and driver conformance
> section adjacent to device specification in each device specific
> directory. This further makes device specification self-contained.
>
> Added patch to fix spelling errors in network device
> specification which was inherited from its previous file
> location.
>
> Patches do not change any part of the specification outcome
> except fixing the spelling errors.
> It only changes how the specification is maintained.
>
> patch summary:
> -------------
> patch 1 to 7 creates new files for moving devices spec out of
> content and conformance files.
> patch 8 to 20 move existing dedicated file spec to new directory
> and creates per device,driver conformance file for each device.

This LGTM now.

Michael: did you check whether redlining works as expected?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

