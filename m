Return-Path: virtio-dev-return-4643-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2016985B72
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Jul 2018 16:27:17 +0000 (UTC)
Date: Fri, 6 Jul 2018 19:27:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180706192609-mutt-send-email-mst@kernel.org>
References: <20180704054347.29527-1-kraxel@redhat.com>
 <5f862616-1c89-0cd6-d547-fedd60669031@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f862616-1c89-0cd6-d547-fedd60669031@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2] Add virtio gpu device specification.
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 05, 2018 at 10:22:17AM +0200, Laszlo Ersek wrote:
> On 07/04/18 07:43, Gerd Hoffmann wrote:
> > Support for 2d mode (3d/virgl mode is not covered by this patch) has
> > been added to the linux kernel version 4.2 and to qemu version 2.4.
> > 
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  content.tex    |   2 +
> >  virtio-gpu.tex | 481 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 483 insertions(+)
> >  create mode 100644 virtio-gpu.tex
> 
> I've diffed the v1 and v2 patch files / emails between each other; the
> typo has been corrected.
> 
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> 
> Also, I had "tested" a good chunk of this spec, by writing a driver
> against it (a basic one, for a UEFI boot environment -- advanced
> features such as host display resizing, multi-head, virgl 3D, pointer
> cursor, are not used). In that context,
> 
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks,
> Laszlo

Thanks a lot!
Gerd, I think we should give this a week or so and then
vote on it if there are no more comments. Pls remember to
request the vote when you think it's appropriate.


> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

