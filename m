Return-Path: virtio-dev-return-4824-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27E00985FED
	for <virtio-dev@lists.oasis-open.org>; Sat,  8 Sep 2018 01:46:22 +0000 (UTC)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sat, 8 Sep 2018 01:46:02 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397924FE@shsmsx102.ccr.corp.intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
 <20180723122342-mutt-send-email-mst@kernel.org>
 <20180723143604.GB2457@work-vm> <5B911B03.2060602@intel.com>
 <20180907122955.GD2544@work-vm>
In-Reply-To: <20180907122955.GD2544@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v36 0/5] Virtio-balloon: support free page reporting
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Friday, September 7, 2018 8:30 PM, Dr. David Alan Gilbert wrote:
> OK, that's much better.
> The ~50% reducton with a 8G VM and a real workload is great, and it does
> what you expect when you put a lot more RAM in and see the 84% reduction
> on a guest with 128G RAM - 54s vs ~9s is a big win!
>=20
> (The migrate_set_speed is a bit high, since that's in bytes/s - but it's =
not
> important).
>=20
> That looks good,
>=20

Thanks Dave for the feedback.
Hope you can join our discussion and review the v37 patches as well.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

