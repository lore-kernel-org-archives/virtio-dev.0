Return-Path: virtio-dev-return-8093-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2D219863F2
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Mar 2021 04:01:15 +0000 (UTC)
References: <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
 <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
 <20210228162306-mutt-send-email-mst@kernel.org>
 <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
 <20210302130812.6227f176.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5f6972fe-7246-b622-958d-9cab8dd98e21@redhat.com>
Date: Wed, 3 Mar 2021 12:01:01 +0800
MIME-Version: 1.0
In-Reply-To: <20210302130812.6227f176.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Content-Type: multipart/alternative;
 boundary="------------B826CAB68AD9EEBB055DC45D"
Content-Language: en-GB
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--------------B826CAB68AD9EEBB055DC45D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2021/3/2 8:08 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
> On Mon, 1 Mar 2021 11:51:08 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2021/3/1 5:25 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote:
>>> On Fri, Feb 26, 2021 at 04:19:16PM +0800, Jason Wang wrote:
>>>> On 2021/2/26 2:53 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote:
>>>>> Confused. What is wrong with the above? It never reads the
>>>>> field unless the feature has been offered by device.
>>>> So the spec said:
>>>>
>>>> "
>>>>
>>>> The following driver-read-only field, max_virtqueue_pairs only exists =
if
>>>> VIRTIO_NET_F_MQ is set.
>>>>
>>>> "
>>>>
>>>> If I read this correctly, there will be no max_virtqueue_pairs field i=
f the
>>>> VIRTIO_NET_F_MQ is not offered by device? If yes the offsetof() violat=
es
>>>> what spec said.
>>>>
>>>> Thanks
>>> I think that's a misunderstanding. This text was never intended to
>>> imply that field offsets change beased on feature bits.
>>> We had this pain with legacy and we never wanted to go back there.
>>>
>>> This merely implies that without VIRTIO_NET_F_MQ the field
>>> should not be accessed. Exists in the sense "is accessible to driver".
>>>
>>> Let's just clarify that in the spec, job done.
>>
>> Ok, agree. That will make things more eaiser.
> Yes, that makes much more sense.
>
> What about adding the following to the "Basic Facilities of a Virtio
> Device/Device Configuration Space" section of the spec:
>
> "If an optional configuration field does not exist, the corresponding
> space is still present, but reserved."


This became interesting after re-reading some of the qemu codes.

E.g in virtio-net.c we had:

*static VirtIOFeature feature_sizes[] =3D {
 =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_MAC,
 =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, mac)},
 =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_STATUS,
 =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, status)}=
,
 =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_MQ,
 =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, max_virt=
queue_pairs)},
 =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_MTU,
 =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, mtu)},
 =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
 =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, duplex)}=
,
 =C2=A0=C2=A0=C2=A0 {.flags =3D (1ULL << VIRTIO_NET_F_RSS) | (1ULL <<=20
VIRTIO_NET_F_HASH_REPORT),
 =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, supporte=
d_hash_types)},
 =C2=A0=C2=A0=C2=A0 {}
};*

*It has a implict dependency chain. E.g MTU doesn't presnet if=20
DUPLEX/RSS is not offered ...
*


>
> (Do we need to specify what a device needs to do if the driver tries to
> access a non-existing field? We cannot really make assumptions about
> config space accesses; virtio-ccw can just copy a chunk of config space
> that contains non-existing fields...


Right, it looks to me ccw doesn't depends on config len which is kind of=20
interesting. I think the answer depends on the implementation of both=20
transport and device:

Let's take virtio-net-pci as an example, it fills status unconditionally=20
in virtio_net_set_config() even if VIRTIO_NET_F_STATUS is not=20
negotiated. So with the above feature_sizes:

1) if one of the MQ, MTU, DUPLEX or RSS is implemented, driver can still=20
read status in this case
2) if none of the above four is negotied, driver can only read a 0xFF=20
(virtio_config_readb())


> I guess the device could ignore
> writes and return zeroes on read?)


So consider the above, it might be too late to fix/clarify that in the=20
spec on the expected behaviour of reading/writing non-exist fields.

Thanks


>
> I've opened https://github.com/oasis-tcs/virtio-spec/issues/98 for the
> spec issues.
>

--------------B826CAB68AD9EEBB055DC45D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2021/3/2 8:08 =E4=B8=8B=E5=8D=88, Cor=
nelia Huck
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20210302130812.6227f176.cohuck@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Mon, 1 Mar 2021 11:51:08 +0=
800
Jason Wang <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:jasowang@redha=
t.com">&lt;jasowang@redhat.com&gt;</a> wrote:

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">On 2021/3/1 5:25 =E4=B8=8A=
=E5=8D=88, Michael S. Tsirkin wrote:
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">On Fri, Feb 26, 2021 at 04=
:19:16PM +0800, Jason Wang wrote: =20
</pre>
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">On 2021/2/26 2:53 =E4=B8=
=8A=E5=8D=88, Michael S. Tsirkin wrote: =20
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <pre class=3D"moz-quote-pre" wrap=3D"">Confused. What is wron=
g with the above? It never reads the
field unless the feature has been offered by device. =20
</pre>
            </blockquote>
            <pre class=3D"moz-quote-pre" wrap=3D"">
So the spec said:

"

The following driver-read-only field, max_virtqueue_pairs only exists if
VIRTIO_NET_F_MQ is set.

"

If I read this correctly, there will be no max_virtqueue_pairs field if the
VIRTIO_NET_F_MQ is not offered by device? If yes the offsetof() violates
what spec said.

Thanks =20
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">I think that's a misunders=
tanding. This text was never intended to
imply that field offsets change beased on feature bits.
We had this pain with legacy and we never wanted to go back there.

This merely implies that without VIRTIO_NET_F_MQ the field
should not be accessed. Exists in the sense "is accessible to driver".

Let's just clarify that in the spec, job done. =20
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">

Ok, agree. That will make things more eaiser.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Yes, that makes much more sense.

What about adding the following to the "Basic Facilities of a Virtio
Device/Device Configuration Space" section of the spec:

"If an optional configuration field does not exist, the corresponding
space is still present, but reserved."</pre>
    </blockquote>
    <p><br>
    </p>
    <p>This became interesting after re-reading some of the qemu codes.</p>
    <p>E.g in virtio-net.c we had:</p>
    <p><b style=3D"font-weight:normal;"
        id=3D"docs-internal-guid-6138ff0e-7fff-1df8-93af-8b0b791ded04"><spa=
n>static
          VirtIOFeature feature_sizes[] =3D {<br>
          =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL &lt;&lt; VIRTIO_NET_F_MAC,<br=
>
          =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config,=
 mac)},<br>
          =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL &lt;&lt; VIRTIO_NET_F_STATUS,=
<br>
          =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config,=
 status)},<br>
          =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL &lt;&lt; VIRTIO_NET_F_MQ,<br>
          =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config,
          max_virtqueue_pairs)},<br>
          =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL &lt;&lt; VIRTIO_NET_F_MTU,<br=
>
          =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config,=
 mtu)},<br>
          =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL &lt;&lt; VIRTIO_NET_F_SPEED_D=
UPLEX,<br>
          =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config,=
 duplex)},<br>
          =C2=A0=C2=A0=C2=A0 {.flags =3D (1ULL &lt;&lt; VIRTIO_NET_F_RSS) |=
 (1ULL
          &lt;&lt; VIRTIO_NET_F_HASH_REPORT),<br>
          =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config,
          supported_hash_types)},<br>
          =C2=A0=C2=A0=C2=A0 {}<br>
          };</span></b></p>
    <p><b style=3D"font-weight:normal;"
        id=3D"docs-internal-guid-6138ff0e-7fff-1df8-93af-8b0b791ded04"><spa=
n>It
          has a implict dependency chain. E.g MTU doesn't presnet if
          DUPLEX/RSS is not offered ...<br>
        </span></b></p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20210302130812.6227f176.cohuck@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

(Do we need to specify what a device needs to do if the driver tries to
access a non-existing field? We cannot really make assumptions about
config space accesses; virtio-ccw can just copy a chunk of config space
that contains non-existing fields... </pre>
    </blockquote>
    <p><br>
    </p>
    <p>Right, it looks to me ccw doesn't depends on config len which is
      kind of interesting. I think the answer depends on the
      implementation of both transport and device:<br>
    </p>
    <p>Let's take virtio-net-pci as an example, it fills status
      unconditionally in virtio_net_set_config() even if
      VIRTIO_NET_F_STATUS is not negotiated. So with the above
      feature_sizes:</p>
    <p>1) if one of the MQ, MTU, DUPLEX or RSS is implemented, driver
      can still read status in this case<br>
      2) if none of the above four is negotied, driver can only read a
      0xFF (virtio_config_readb())</p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20210302130812.6227f176.cohuck@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">I guess the device could ignor=
e
writes and return zeroes on read?)</pre>
    </blockquote>
    <p><br>
    </p>
    <p>So consider the above, it might be too late to fix/clarify that
      in the spec on the expected behaviour of reading/writing non-exist
      fields.</p>
    <p>Thanks<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20210302130812.6227f176.cohuck@redhat.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

I've opened <a class=3D"moz-txt-link-freetext" href=3D"https://github.com/o=
asis-tcs/virtio-spec/issues/98">https://github.com/oasis-tcs/virtio-spec/is=
sues/98</a> for the
spec issues.

</pre>
    </blockquote>
  </body>
</html>

--------------B826CAB68AD9EEBB055DC45D--

