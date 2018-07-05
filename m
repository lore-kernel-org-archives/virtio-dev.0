Return-Path: virtio-dev-return-4639-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85ABE985B5D
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Jul 2018 08:22:27 +0000 (UTC)
References: <20180704054347.29527-1-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5f862616-1c89-0cd6-d547-fedd60669031@redhat.com>
Date: Thu, 5 Jul 2018 10:22:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180704054347.29527-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2] Add virtio gpu device specification.
To: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/04/18 07:43, Gerd Hoffmann wrote:
> Support for 2d mode (3d/virgl mode is not covered by this patch) has
> been added to the linux kernel version 4.2 and to qemu version 2.4.
> 
> Cc: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  content.tex    |   2 +
>  virtio-gpu.tex | 481 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 483 insertions(+)
>  create mode 100644 virtio-gpu.tex

I've diffed the v1 and v2 patch files / emails between each other; the
typo has been corrected.

Acked-by: Laszlo Ersek <lersek@redhat.com>

Also, I had "tested" a good chunk of this spec, by writing a driver
against it (a basic one, for a UEFI boot environment -- advanced
features such as host display resizing, multi-head, virgl 3D, pointer
cursor, are not used). In that context,

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

