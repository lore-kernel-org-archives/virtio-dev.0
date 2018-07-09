Return-Path: rkagan@virtuozzo.com
Date: Mon, 09 Jul 2018 06:14:19 -0700
From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
Message-ID: <20180709131419.GB6271@rkaganb.sw.ru>
References: <20180629221907.3662-1-venu.busireddy@oracle.com> <20180702161404.GA2339@rkaganb.sw.ru>
 <449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com> <20180703095825.GC30904@rkaganb.sw.ru>
 <20180703142817.GA3088@vbusired-vm> <20180703165200.180c93bb.cohuck@redhat.com>
 <CADGSJ23+sZiMCx=n=DytZ=TT2z7i0sMhrmnPuFYtuZhSc=qA+Q@mail.gmail.com> <20180704141523.377cb66d.cohuck@redhat.com>
 <CADGSJ206U4x0UNTEKu0Lt9K9qA025ajtmnj6ym4PDz4Q-c8RKA@mail.gmail.com> <20180706155406.0587733c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706155406.0587733c.cohuck@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, si-wei liu <si-wei.liu@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 06, 2018 at 03:54:06PM +0200, Cornelia Huck wrote:
> If we want to extend that to other device types, we can add the field
> in their config space; but I'd rather prefer a more generic "host
> relays config metainformation" approach.

The problem with this approach is that it's too generic and poorly
scoped.  As a result I guess it's likely to take ages to converge.

See for instance the discussion on including vm config metadata in qcow2
images: I think it's similar in scope (or the absense thereof).

Roman.
