Return-Path: virtio-dev-return-5215-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D985B985E31
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Dec 2018 08:04:02 +0000 (UTC)
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
 <1535333539-32420-2-git-send-email-wei.w.wang@intel.com>
 <49d706f7-a0ee-e571-7d02-bcadac5ce742@de.ibm.com>
 <5C259485.2030809@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 28 Dec 2018 09:03:46 +0100
In-Reply-To: <5C259485.2030809@intel.com>
Content-Language: en-US
Message-Id: <2e801749-eb66-1d68-3c06-67cc6508e067@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v37 1/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, dgilbert@redhat.com
Cc: torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com, quintela@redhat.com, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 28.12.2018 04:12, Wei Wang wrote:
> On 12/27/2018 08:03 PM, Christian Borntraeger wrote:
>> On 27.08.2018 03:32, Wei Wang wrote:
>>> =C2=A0 static int init_vqs(struct virtio_balloon *vb)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 struct virtqueue *vqs[3];
>>> -=C2=A0=C2=A0=C2=A0 vq_callback_t *callbacks[] =3D { balloon_ack, ballo=
on_ack, stats_request };
>>> -=C2=A0=C2=A0=C2=A0 static const char * const names[] =3D { "inflate", =
"deflate", "stats" };
>>> -=C2=A0=C2=A0=C2=A0 int err, nvqs;
>>> +=C2=A0=C2=A0=C2=A0 struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
>>> +=C2=A0=C2=A0=C2=A0 vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
>>> +=C2=A0=C2=A0=C2=A0 const char *names[VIRTIO_BALLOON_VQ_MAX];
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * We expect two virtqueues: inflate and defla=
te, and
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * optionally stat.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Inflateq and deflateq are used unconditiona=
lly. The names[]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * will be NULL if the related feature is not =
enabled, which will
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cause no allocation for the corresponding v=
irtqueue in find_vqs.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> This might be true for virtio-pci, but it is not for virtio-ccw.
>=20
> Hi Christian,
>=20
>=20
> Please try the fix patches: https://lkml.org/lkml/2018/12/27/336

See answer to that thread. It fixes the random boot crashes.
There is still the regression that ballooning does no longer work on
s390 (see the call trace).


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

