Return-Path: virtio-dev-return-7150-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F015C985FF8
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Apr 2020 16:02:52 +0000 (UTC)
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182120.12258.67417.stgit@localhost.localdomain>
 <2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
 <CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <46fb7362-0ec7-d27d-a8bc-458e9ae0beea@redhat.com>
Date: Thu, 23 Apr 2020 18:02:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v21 QEMU 4/5] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 23.04.20 16:46, Alexander Duyck wrote:
> On Thu, Apr 23, 2020 at 1:11 AM David Hildenbrand <david@redhat.com> wrot=
e:
>>
>> On 22.04.20 20:21, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> We need to make certain to advertise support for page poison tracking i=
f
>>> we want to actually get data on if the guest will be poisoning pages.
>>>
>>> Add a value for tracking the poison value being used if page poisoning =
is
>>> enabled. With this we can determine if we will need to skip page report=
ing
>>> when it is enabled in the future.
>>
>> Maybe add something about the semantics
>>
>> "VIRTIO_BALLOON_F_PAGE_POISON will not change the behavior of free page
>> hinting or ordinary balloon inflation/deflation."
>>
>> I do wonder if we should just unconditionally enable
>> VIRTIO_BALLOON_F_PAGE_POISON here, gluing it to the QEMU compat machine
>> (via a property that is default-enabled, and disabled from compat machin=
es).
>>
>> Because, as Michael said, knowing that the guest is using page poisoning
>> might be interesting even if free page reporting is not around.
>=20
> I could do that. So if that is the case though would I disable page
> reporting if it isn't enabled, or would I be enabling page poison if
> page reporting is enabled?


So, I would suggest this the following as a diff to this patch (the TODO pa=
rt as a
separate patch - we will have these compat properties briefly after the 5.0
release)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c1a444cb75..2e96cba4ff 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,6 +28,12 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
=20
+// TODO: After 5.0 release
+GlobalProperty hw_compat_5_0[] =3D {
+    { "virtio-balloon-device", "page-hint", "false"},
+};
+const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
+
 GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-blk-device", "queue-size", "128"},
     { "virtio-scsi-device", "virtqueue_size", "128"},
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..5ff8a669cf 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -924,6 +924,8 @@ static Property virtio_balloon_properties[] =3D {
                      qemu_4_0_config_size, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
+    DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_PAGE_POISON, true),
     DEFINE_PROP_END_OF_LIST(),
 };


What to do with page reporting depends: I would not implicitly enable featu=
res.
I think we are talking about

-device virtio-balloon-pci,...,page-poison=3Dfalse,free-page-reporting=3Dtr=
ue

a) Valid scenario. Fix Linux guests as we discussed to not use reporting if=
 they rely on page poisoning.
b) Invalid scenario. E.g., bail out when trying to realize that device ("'f=
ree-page-reporting' requires 'page-poison'").

With new QEMU machines, this should not happen with

-device virtio-balloon-pci,...,free-page-reporting=3Dtrue

as page-poison=3Dtrue is the new default.

What's your opinion?

>=20
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>>  hw/virtio/virtio-balloon.c         |    7 +++++++
>>>  include/hw/virtio/virtio-balloon.h |    1 +
>>>  2 files changed, 8 insertions(+)
>>>
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index a1d6fb52c876..5effc8b4653b 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice =
*vdev, uint8_t *config_data)
>>>
>>>      config.num_pages =3D cpu_to_le32(dev->num_pages);
>>>      config.actual =3D cpu_to_le32(dev->actual);
>>> +    config.poison_val =3D cpu_to_le32(dev->poison_val);
>>>
>>>      if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_REQUESTED) =
{
>>>          config.free_page_hint_cmd_id =3D
>>> @@ -697,6 +698,10 @@ static void virtio_balloon_set_config(VirtIODevice=
 *vdev,
>>>          qapi_event_send_balloon_change(vm_ram_size -
>>>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PF=
N_SHIFT));
>>>      }
>>> +    dev->poison_val =3D 0;
>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>>> +        dev->poison_val =3D le32_to_cpu(config.poison_val);
>>> +    }
>>>      trace_virtio_balloon_set_config(dev->actual, oldactual);
>>>  }
>>>
>>> @@ -854,6 +859,8 @@ static void virtio_balloon_device_reset(VirtIODevic=
e *vdev)
>>>          g_free(s->stats_vq_elem);
>>>          s->stats_vq_elem =3D NULL;
>>>      }
>>> +
>>> +    s->poison_val =3D 0;
>>>  }
>>>
>>>  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t stat=
us)
>>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/vir=
tio-balloon.h
>>> index 108cff97e71a..3ca2a78e1aca 100644
>>> --- a/include/hw/virtio/virtio-balloon.h
>>> +++ b/include/hw/virtio/virtio-balloon.h
>>> @@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
>>>      uint32_t host_features;
>>>
>>>      bool qemu_4_0_config_size;
>>> +    uint32_t poison_val;
>>>  } VirtIOBalloon;
>>>
>>>  #endif
>>>
>>
>> You still have to migrate poison_val if I am not wrong, otherwise you
>> would lose it during migration if I am not mistaking.
>=20
> So what are the requirements to migrate a value? Would I need to add a
> property so it can be retrieved/set?
>=20

Something like this would do the trick:

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..ea0afec5f6 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -522,6 +522,13 @@ static bool virtio_balloon_free_page_support(void *opa=
que)
     return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
 }
=20
+static bool virtio_balloon_page_poison_support(void *opaque)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+}
+
 static void virtio_balloon_free_page_start(VirtIOBalloon *s)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
@@ -755,6 +762,17 @@ static const VMStateDescription vmstate_virtio_balloon=
_free_page_report =3D {
     }
 };
=20
+static const VMStateDescription vmstate_virtio_balloon_page_poison =3D {
+    .name =3D "vitio-balloon-device/page-poison",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D virtio_balloon_page_poison_support,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(poison_val, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_balloon_device =3D {
     .name =3D "virtio-balloon-device",
     .version_id =3D 1,
@@ -767,6 +785,7 @@ static const VMStateDescription vmstate_virtio_balloon_=
device =3D {
     },
     .subsections =3D (const VMStateDescription * []) {
         &vmstate_virtio_balloon_free_page_report,
+        &vmstate_virtio_balloon_page_poison,
         NULL
     }
 };




But I *think* the following should work as well IIRC (could be that migrati=
ng new QEMU
-> old QEMU would be an issue, I don't recall if both directions are safe):


diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..01bccf26fb 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -757,12 +757,13 @@ static const VMStateDescription vmstate_virtio_balloo=
n_free_page_report =3D {
=20
 static const VMStateDescription vmstate_virtio_balloon_device =3D {
     .name =3D "virtio-balloon-device",
-    .version_id =3D 1,
+    .version_id =3D 2,
     .minimum_version_id =3D 1,
     .post_load =3D virtio_balloon_post_load_device,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(num_pages, VirtIOBalloon),
         VMSTATE_UINT32(actual, VirtIOBalloon),
+        VMSTATE_UINT32_V(poison_val, VirtIOBalloon, 2),
         VMSTATE_END_OF_LIST()
     },
     .subsections =3D (const VMStateDescription * []) {


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

