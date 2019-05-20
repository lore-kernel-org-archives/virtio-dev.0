Return-Path: virtio-dev-return-5753-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47B1C985E6A
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 May 2019 22:03:21 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
References: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
Message-ID: <05fba85f-62c4-deae-f98c-493e6e374f8f@arrikto.com>
Date: Tue, 21 May 2019 01:03:18 +0300
MIME-Version: 1.0
In-Reply-To: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v3 0/4] introduce virtio vhost-user backend
 device type
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi all,

This is a kind reminder to solicit comments on this patchset, and ask
for next steps. What can I do to help with the process of merging this?

Best regards,
Nikos

On 11/5/19 9:47 μ.μ., Nikos Dragazis wrote:
> Hi everyone,
>
> this PATCH presents an updated version of the RFC virtio device spec for
> the virtio-vhost-user device. The initial RFC implementation can be
> found here: [1].
>
> This PATCH is split into four parts:
>
> 1. the first commit is just a refactored version of the initial RFC
> implementation [1]. I just moved the device spec into a separate .tex
> file and changed the device id from #24 to #28 since the ids #24-#27 are
> reserved.
>
> 2. the second commit fixes some minor issues with the device spec. This
> is quite straightforward.
>
> 3. the third commit enhances the notification capability with some
> device/driver requirements. This makes sense because the notification
> capability behaves similarly to the MSI-X capability, thereby having
> some requirements that need to be mentioned.
>
> 4. the fourth commit synchronizes the shared memory capability with a
> recent patch [2] that attempts to standardize a standalone
> SHARED_MEMORY_CFG virtio capability.
>
> v3 changes:
>  * Device Requirements for the Notification Capability: point out the
>    difference between the MSI-X Table Size stored in the Message Control
>    register of the MSI-X capability structure and the actual MSI-X Table
>    Size
>
> v2 changes:
>  * Change device id from #25 to #28
>
> Looking forward to your comments.
>
> Thanks,
> Nikos
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/201801/msg00110.html
> [2] https://lists.oasis-open.org/archives/virtio-dev/201902/msg00142.html
>
> Nikos Dragazis (3):
>   vhost-user: minor fixes
>   vhost-user: add requirements for the notification capability
>   vhost-user: update shared memory capability
>
> Stefan Hajnoczi (1):
>   vhost-user: add vhost-user device type
>
>  content.tex           |   3 +
>  introduction.tex      |   1 +
>  virtio-vhost-user.tex | 349 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 353 insertions(+)
>  create mode 100644 virtio-vhost-user.tex
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

