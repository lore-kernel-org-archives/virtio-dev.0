Return-Path: virtio-dev-return-4403-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D44C7581810D
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jun 2018 07:29:02 -0700 (PDT)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Fri, 15 Jun 2018 14:28:49 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396A3DC9@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <20180615142610-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180615142610-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v33 0/4] Virtio-balloon: support free page reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Friday, June 15, 2018 7:30 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 15, 2018 at 12:43:09PM +0800, Wei Wang wrote:
> >       - remove the cmd id related interface. Now host can just send a f=
ree
> >         page hint command to the guest (via the host_cmd config registe=
r)
> >         to start the reporting.
>=20
> Here we go again. And what if reporting was already started previously?
> I don't think it's a good idea to tweak the host/guest interface yet agai=
n.

This interface is much simpler, and I'm not sure if that would be an issue =
here now, because
now the guest delivers the whole buffer of hints to host once, instead of h=
int by hint as before. And the guest notifies host after the buffer is deli=
vered. In any case, the host doorbell handler will be invoked, if host does=
n't need the hints at that time, it will just give back the buffer. There w=
ill be no stale hints remained in the ring now.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

