Return-Path: virtio-dev-return-7786-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F551986008
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Sep 2020 10:19:11 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Message-ID: <82383315-12d3-6fbd-37b0-c1c31ea7fb8d@arrikto.com>
Date: Thu, 17 Sep 2020 13:19:08 +0300
MIME-Version: 1.0
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] Re: [PATCH 00/11] Additional virtio device resources
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 24/8/20 5:36 =CE=BC.=CE=BC., Nikos Dragazis wrote:

> Hi everyone,
>
> This patch introduces the "doorbells" and "device-specific
> notifications" as a new set of virtio device resources.
>
> Doorbells are device registers that allow a driver to notify the device
> for events other than virtqueue activity.
>
> Device-specific notifications are interrupts that allow a device to
> notify the driver for events other than virtqueue activity and
> configuration changes.
>
> The purpose of both of these resources is to allow a virtio device to
> send/receive **device-specific** notifications to/from the driver. This
> is not supported by the current version of the virtio spec, since the
> only notifications supported are configuration changes, available and
> used buffer notifications.
>
> These resources will be used later by the virtio-vhost-user [1] device
> in order to send/receive notifications to/from the driver regarding
> activity on the vhost-user virtqueues. By standardizing these resources
> as standalone virtio device resources, other future devices will be able
> to use them as well.
>
> Also, note that this patch contains some fix commits for some minor
> typos/bugs that I bumped into while writing this patch.
>
> Nikos
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202005/msg00132.html
>
> Nikos Dragazis (11):
>    content: Remove duplicate content
>    content: Minor fix
>    content: Update list of virtio cfg structures
>    content: Minor layout fix
>    doorbells: Introduce doorbells
>    content: Introduce Doorbell cfg type for PCI
>    content: Introduce Doorbell register for MMIO
>    notifications: Introduce device-specific notifications
>    content: Introduce device-specific notification cfg type for PCI
>    content: Fix typo
>    content: Introduce device-specific notifications for MMIO
>
>   conformance.tex |   2 +
>   content.tex     | 177 ++++++++++++++++++++++++++++++++++++++++--------
>   doorbells.tex   |  12 ++++
>   3 files changed, 163 insertions(+), 28 deletions(-)
>   create mode 100644 doorbells.tex
>

Kind reminder on this.

Michael, did you have the chance to look at this?
Looking forward to your feedback so that we can discuss.

Thanks,
Nikos

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

