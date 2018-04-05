Return-Path: virtio-dev-return-3726-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A1905818F21
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Apr 2018 19:05:17 -0700 (PDT)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Thu, 5 Apr 2018 02:05:03 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7394A7F3B@shsmsx102.ccr.corp.intel.com>
References: <1522771805-78927-1-git-send-email-wei.w.wang@intel.com>
 <1522771805-78927-3-git-send-email-wei.w.wang@intel.com>
 <20180403214147-mutt-send-email-mst@kernel.org> <5AC43377.2070607@intel.com>
 <20180404155907-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7394A6E96@shsmsx102.ccr.corp.intel.com>
 <20180405040900-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180405040900-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v30 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "huangzhichao@huawei.com" <huangzhichao@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thursday, April 5, 2018 9:12 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 05, 2018 at 12:30:27AM +0000, Wang, Wei W wrote:
> > On Wednesday, April 4, 2018 10:08 PM, Michael S. Tsirkin wrote:
> > > On Wed, Apr 04, 2018 at 10:07:51AM +0800, Wei Wang wrote:
> > > > On 04/04/2018 02:47 AM, Michael S. Tsirkin wrote:
> > > > > On Wed, Apr 04, 2018 at 12:10:03AM +0800, Wei Wang wrote:
> > I'm afraid the driver couldn't be aware if the added hints are stale
> > or not,
>=20
>=20
> No - I mean that driver has code that compares two values and stops
> reporting. Can one of the values be stale?

The driver compares "vb->cmd_id_use !=3D vb->cmd_id_received" to decide if =
it needs to stop reporting hints, and cmd_id_received is what the driver re=
ads from host (host notifies the driver to read for the latest value). If h=
ost sends a new cmd id, it will notify the guest to read again. I'm not sur=
e how that could be a stale cmd id (or maybe I misunderstood your point her=
e?)

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

