Return-Path: virtio-dev-return-4754-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE7FE985C9D
	for <virtio-dev@lists.oasis-open.org>; Sat, 28 Jul 2018 02:00:18 +0000 (UTC)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sat, 28 Jul 2018 02:00:13 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397114A2@SHSMSX101.ccr.corp.intel.com>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
 <20180727170605-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180727170605-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v2 0/2] virtio-balloon: some improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Friday, July 27, 2018 10:06 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 27, 2018 at 05:24:53PM +0800, Wei Wang wrote:
> > This series is split from the "Virtio-balloon: support free page
> > reporting" series to make some improvements.
> >
> > v1->v2 ChangeLog:
> > - register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is
> negotiated.
> >
> > Wei Wang (2):
> >   virtio-balloon: remove BUG() in init_vqs
> >   virtio_balloon: replace oom notifier with shrinker
>=20
> Thanks!
> Given it's very late in the release cycle, I'll merge this for the next L=
inux
> release.

No problem. Thanks!

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

