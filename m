Return-Path: <virtio-dev-return-13100-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A00FC001DE
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:28:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AD32733588
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:28:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A646198642B
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:28:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 97FCA986413; Tue, 27 Jun 2023 08:28:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8464998635B;
	Tue, 27 Jun 2023 08:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vm4zdH._1687854487;
Message-ID: <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
Date: Tue, 27 Jun 2023 16:23:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org,
 mst@redhat.com,
 parav@nvidia.com,
 virtio-comment@lists.oasis-open.org,"Jason Wang" <jasowang@redhat.com>,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member to the device


Thanks Parav for pointing it out. We may have some gaps on the case.

Let me introduce our case, which I think it is simple and should be easy to
understand.

First, the user (customer) purchased a bare metal machine.

## Bare metal machine

Let me briefly explain the characteristics of a bare metal machine. It is not a
virtual machine, it is a physical machine, and the difference between it and a
general physical machine is that its PCI is connected to a device similar to a
DPU. This DPU provides devices such as virtio-blk/net to the host through PCI.
These devices are managed by the vendor, and must be created and purchased
on the vendor's management platform.

## DPU

There is a software implementation in the DPU, which will respond to PCI
operations. But as mentioned above, resources such as network cards must be
purchased and created before they can exist. So users can create VF, which is
just a pci-level operation, but there may not be a corresponding backend.

## Management Platform

The creation and configuration of devices is realized on the management
platform.

After the user completed the purchase on the management platform (this is an
independent platform provided by the vendor and has nothing to do with
virtio), then there will be a corresponding device implementation in the DPU.
This includes some user configurations, available bandwidth resources and other
information.

## Usage

Since the user is directly on the HOST, the user can create VMs, passthrough PF
or VF into the VM. Or users can create a large number of dockers, all of which
use a separate virtio-net device for performance.

The reason why users use vf is that we need to use a large number of virtio-net
devices. This number reaches 1k+.

Based on this scenario, we need to bind vf to the backend device. Because, we
cannot automatically complete the creation of the virtio-net backend device when
the user creates a vf.

## Migration

In addition, let's consider another scenario of migration. If a vm is migrated
from another host, of course its corresponding virtio device is also migrated to
the DPU. At this time, our newly created vf can only be used by the vm after it
is bound to the migrated device. We do not want this vf to be a brand new
device.

## Abstraction

So, this is how I understand the process of creating vf:

1. Create a PCI VF, at this time there may be no backend virtio device, or there
    is only a default backend. It does not fully meet our expectations.
2. Create device or migrate device
3. Bind the backend virtio device to the vf

In most scenarios, the first step may be enough. We can make some fine-tuning on
this default device, such as modifying its mac. In the future, we can use admin
queue to modify its msix vector and other configurations.

But we should allow, we bind a backend virtio device to a certain vf. This is
useful for live migration and virtio devices with special configurations.

The design of virtio itself is two layers, and virtio should allow switching the
transport layer by nature. This is our advantage.

## About the identity

In this patch, I used a vendor's id. The purpose of this is that I hope to
be compatible with all devices. In the network scenario, it is actually possible
to use a mac.

Perhaps, introduce a standard id for each device/driver, I think this may be
more in line with the habit of virtio spec.

Thanks.

On Mon, 26 Jun 2023 14:22:10 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> The VFs of the SR-IOV are created by the user inside the guest OS, so the virtio
> devices don't know about these VFs. Because each VF may be assigned a different role
> by the user, the virtio device can not choose one VF to bind random.
> So only the user knows how to bind the virtio devices to the VFs.
> On the other hand, generally the virtio devices are not created by the user
> inside the guest OS. This requires some management platform to participate.
>
> So the usage of this command:
> 1. The user purchases a virtio network card on the management platform,
>    and sets the ip, queue number, etc. The user obtains the identity of
>    the network card.
> 2. The user creates a VF with echo 8 > sriov_numvfs
> 3. The user binds the net crad to a VF with identity through the command
>    of the patch
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/admin.tex b/admin.tex
> index 2efd4d7..64d0667 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -115,7 +115,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \hline \hline
>  0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
>  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one group member \\
> +0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
>  \hline
> @@ -429,6 +430,44 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \field{VF Enable} refer to registers within the SR-IOV Extended
>  Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
>
> +\subsubsection{Bind the device for member}
> +
> +The VFs of the SR-IOV are created by the user inside the guest OS, so the virtio
> +devices don't know about these VFs. Because each VF may be assigned a different role
> +by the user, the virtio device can not choose one VF to bind random.
> +So only the user knows how to bind the virtio devices to the VFs.
> +On the other hand, generally the virtio devices are not created by the user
> +inside the guest OS. This requires some management platform to participate.
> +
> +So we introduce a new admin queue command to bind the VFs and the virtio
> +devices.
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_bind {
> +    u64 identity;
> +};
> +\end{lstlisting}
> +
> +The user got the \field{identity} from the management platform, that is not
> +included by this spec.
> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Bind the device for member}
> +
> +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the \field{group_member_id} MUST be set.
> +
> +The \field{identity} is passed by the user. It is the identity of the virtio
> +device.
> +
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Bind the device for member}
> +
> +Every device MUST have one unique \field{identity} in the host.
> +
> +If the PF device can not find the device by the \field{identity},
> +the \field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
> +
> +If the device is found by the \field{identity}, the device MUST work as the
> +device of this group member specified by the \field{group_member_id}.
> +
>  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>
>  An administration virtqueue of an owner device is used to submit
> --
> 2.32.0.3.g01195cf9f
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

