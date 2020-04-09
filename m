Return-Path: virtio-dev-return-7036-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A639C985F51
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Apr 2020 14:42:09 +0000 (UTC)
MIME-Version: 1.0
References: <20200408225302.18764.209.stgit@localhost.localdomain>
 <20200408225523.18764.86514.stgit@localhost.localdomain> <a461c334-79f0-a638-962e-d6b136707ce3@redhat.com>
In-Reply-To: <a461c334-79f0-a638-962e-d6b136707ce3@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 9 Apr 2020 07:41:57 -0700
Message-ID: <CAKgT0Ueu4P4Z-fNZiEnHDV2nCSrW7qJWVD17=VLHt_Le00NSWg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v18 QEMU 2/3] virtio-balloon: Add support for providing
 free page reports to host
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 9, 2020 at 12:36 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.04.20 00:55, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Add support for the page reporting feature provided by virtio-balloon.
> > Reporting differs from the regular balloon functionality in that is is
> > much less durable than a standard memory balloon. Instead of creating a
> > list of pages that cannot be accessed the pages are only inaccessible
> > while they are being indicated to the virtio interface. Once the
> > interface has acknowledged them they are placed back into their respect=
ive
> > free lists and are once again accessible by the guest system.
> >
> > Unlike a standard balloon we don't inflate and deflate the pages. Inste=
ad
> > we perform the reporting, and once the reporting is completed it is
> > assumed that the page has been dropped from the guest and will be fault=
ed
> > back in the next time the page is accessed.
> >
> > This patch is a subset of the UAPI patch that was submitted for the Lin=
ux
> > kernel. The original patch can be found at:
> > https://lore.kernel.org/lkml/20200211224657.29318.68624.stgit@localhost=
.localdomain/
>
> You don't need all these comments.

Sorry about that. Those are basically the same comments from the
original upstream patch. I just wasn't aware of the process so I just
copied that over and added the comment/link to the original patch.

> Usually we do
>
> "linux-headers: update to contain virito-balloon free page reporting
>
> Let's sync the latest upstream changes for free page reporting. To be
> replaced by a full linux header sync.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> "
>
> mst will replace this by a full header sync (if necessary) when sending
> it upstream

I will update the patch description.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

