Return-Path: virtio-dev-return-7149-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C976985FEC
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Apr 2020 14:46:36 +0000 (UTC)
MIME-Version: 1.0
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182120.12258.67417.stgit@localhost.localdomain> <2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
In-Reply-To: <2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 23 Apr 2020 07:46:22 -0700
Message-ID: <CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v21 QEMU 4/5] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 23, 2020 at 1:11 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.04.20 20:21, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > We need to make certain to advertise support for page poison tracking i=
f
> > we want to actually get data on if the guest will be poisoning pages.
> >
> > Add a value for tracking the poison value being used if page poisoning =
is
> > enabled. With this we can determine if we will need to skip page report=
ing
> > when it is enabled in the future.
>
> Maybe add something about the semantics
>
> "VIRTIO_BALLOON_F_PAGE_POISON will not change the behavior of free page
> hinting or ordinary balloon inflation/deflation."
>
> I do wonder if we should just unconditionally enable
> VIRTIO_BALLOON_F_PAGE_POISON here, gluing it to the QEMU compat machine
> (via a property that is default-enabled, and disabled from compat machine=
s).
>
> Because, as Michael said, knowing that the guest is using page poisoning
> might be interesting even if free page reporting is not around.

I could do that. So if that is the case though would I disable page
reporting if it isn't enabled, or would I be enabling page poison if
page reporting is enabled?

> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |    7 +++++++
> >  include/hw/virtio/virtio-balloon.h |    1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index a1d6fb52c876..5effc8b4653b 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice =
*vdev, uint8_t *config_data)
> >
> >      config.num_pages =3D cpu_to_le32(dev->num_pages);
> >      config.actual =3D cpu_to_le32(dev->actual);
> > +    config.poison_val =3D cpu_to_le32(dev->poison_val);
> >
> >      if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_REQUESTED) =
{
> >          config.free_page_hint_cmd_id =3D
> > @@ -697,6 +698,10 @@ static void virtio_balloon_set_config(VirtIODevice=
 *vdev,
> >          qapi_event_send_balloon_change(vm_ram_size -
> >                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PF=
N_SHIFT));
> >      }
> > +    dev->poison_val =3D 0;
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> > +        dev->poison_val =3D le32_to_cpu(config.poison_val);
> > +    }
> >      trace_virtio_balloon_set_config(dev->actual, oldactual);
> >  }
> >
> > @@ -854,6 +859,8 @@ static void virtio_balloon_device_reset(VirtIODevic=
e *vdev)
> >          g_free(s->stats_vq_elem);
> >          s->stats_vq_elem =3D NULL;
> >      }
> > +
> > +    s->poison_val =3D 0;
> >  }
> >
> >  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t stat=
us)
> > diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/vir=
tio-balloon.h
> > index 108cff97e71a..3ca2a78e1aca 100644
> > --- a/include/hw/virtio/virtio-balloon.h
> > +++ b/include/hw/virtio/virtio-balloon.h
> > @@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
> >      uint32_t host_features;
> >
> >      bool qemu_4_0_config_size;
> > +    uint32_t poison_val;
> >  } VirtIOBalloon;
> >
> >  #endif
> >
>
> You still have to migrate poison_val if I am not wrong, otherwise you
> would lose it during migration if I am not mistaking.

So what are the requirements to migrate a value? Would I need to add a
property so it can be retrieved/set?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

