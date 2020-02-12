Return-Path: virtio-dev-return-6735-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC4E0985DC0
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Feb 2020 03:55:00 +0000 (UTC)
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
Date: Wed, 12 Feb 2020 11:54:53 +0800
MIME-Version: 1.0
In-Reply-To: <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Content-Type: multipart/alternative;
 boundary="------------44FD458F3BC9286B8F433811"
To: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------44FD458F3BC9286B8F433811
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2/11/2020 3:40 PM, Jason Wang wrote:
>
> On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
>>
>>
>> On 2/11/2020 12:02 PM, Jason Wang wrote:
>>>
>>> On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>>>>
>>>> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>>>>
>>>>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>
>>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of=20
>>>>>> using
>>>>>> virtio over mmio devices as a lightweight machine model for modern
>>>>>> cloud. The standard virtio over MMIO transport layer only=20
>>>>>> supports one
>>>>>> legacy interrupt, which is much heavier than virtio over PCI=20
>>>>>> transport
>>>>>> layer using MSI. Legacy interrupt has long work path and causes=20
>>>>>> specific
>>>>>> VMExits in following cases, which would considerably slow down the
>>>>>> performance:
>>>>>>
>>>>>> 1) read interrupt status register
>>>>>> 2) update interrupt status register
>>>>>> 3) write IOAPIC EOI register
>>>>>>
>>>>>> We proposed to add MSI support for virtio over MMIO via new feature
>>>>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>>>>>
>>>>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio=20
>>>>>> MSI
>>>>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>>>>> Bit 1 is 0: device uses non-sharing and fixed vector per event=20
>>>>>> mapping.
>>>>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>>>>
>>>>>
>>>>> I believe dynamic mapping should cover the case of fixed vector?
>>>>>
>>>> Actually this bit *aims* for msi sharing or msi non-sharing.
>>>>
>>>> It means, when msi sharing bit is 1, device doesn't want vector per=20
>>>> queue
>>>>
>>>> (it wants msi vector sharing as name) and doesn't want a high=20
>>>> interrupt rate.
>>>>
>>>> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>>>>
>>>> So they are opposite not superset.
>>>>
>>>> Thanks!
>>>>
>>>> Jing
>>>
>>>
>>> I think you need add more comments on the command.
>>>
>>> E.g if I want to map vector 0 to queue 1, how do I need to do?
>>>
>>> write(1, queue_sel);
>>> write(0, vector_sel);
>>
>> That's true. Besides, two commands are used for msi sharing mode,
>>
>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
>>
>> "To set up the event and vector mapping for MSI sharing mode, driver=20
>> SHOULD write a valid MsiVecSel followed by=20
>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command=20
>> to map the configuration change/selected queue events respectively.=C2=
=A0=20
>> " (See spec patch 5/5)
>>
>> So if driver detects the msi sharing mode, when it does setup vq,=20
>> writes the queue_sel (this already exists in setup vq), vector sel=20
>> and then MAP_QUEUE command to do the queue event mapping.
>>
>
> So actually the per vq msix could be done through this.=20

Right, per vq msix can also be mapped by the 2 commands if we want.

The current design benefits for those devices requesting per vq msi that=20
driver

doesn't have to map during setup each queue,

since we define the relationship by default.


> I don't get why you need to introduce MSI_SHARING_MASK which is the=20
> charge of driver instead of device.=20

MSI_SHARING_MASK is just for identifying the msi_sharing bit in=20
readl(MsiState) (0x0c4). The device tells whether it wants msi_sharing.

MsiState register: R

le32 {
 =C2=A0=C2=A0=C2=A0 msi_enabled : 1;
 =C2=A0=C2=A0=C2=A0 msi_sharing: 1;
 =C2=A0=C2=A0=C2=A0 reserved : 30;
};

> The interrupt rate should have no direct relationship with whether it=20
> has been shared or not.

>
> Btw, you introduce mask/unmask without pending, how to deal with the=20
> lost interrupt during the masking then?
>
>
>> For msi non-sharing mode, no special action is needed because we make=20
>> the rule of per_vq_vector and fixed relationship.
>>
>> Correct me if this is not that clear for spec/code comments.
>>
>
> The ABI is not as straightforward as PCI did. Why not just reuse the=20
> PCI layout?
>
> E.g having
>
> queue_sel
> queue_msix_vector
> msix_config
>
> for configuring map between msi vector and queues/config

Thanks for the advice. :)

Actually when looking into pci, the queue_msix_vector/msix_config is the=20
msi vector index, which is the same as the mmio register MsiVecSel (0x0d0).

So we don't introduce two extra registers for mapping even in sharing mode.

What do you think?


>
> Then
>
> vector_sel
> address
> data
> pending
> mask
> unmask
>
> for configuring msi table?

PCI-like msix table is not introduced to device and instead simply use=20
commands to tell the mask/configure/enable.

Thanks!

Jing

>
> Thanks
>
>
>> Thanks!
>>
>> Jing
>>
>>
>>>
>>> ?
>>>
>>> Thanks
>>>
>>>
>>>>
>>>>
>>>>> Thanks
>>>>>
>>>>>
>>>>>
>>>>> ---------------------------------------------------------------------
>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>>
>>>>
>>>
>

--------------44FD458F3BC9286B8F433811
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2/11/2020 3:40 PM, Jason Wang wrote:<=
br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">
      <br>
      On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
      <br>
      <blockquote type=3D"cite">
        <br>
        <br>
        On 2/11/2020 12:02 PM, Jason Wang wrote:
        <br>
        <blockquote type=3D"cite">
          <br>
          On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
          <br>
          <blockquote type=3D"cite">
            <br>
            On 2/11/2020 11:17 AM, Jason Wang wrote:
            <br>
            <blockquote type=3D"cite">
              <br>
              On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
              <br>
              <blockquote type=3D"cite">From: Liu
                Jiang<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:gerr=
y@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a>
                <br>
                <br>
                Userspace VMMs (e.g. Qemu microvm, Firecracker) take
                advantage of using
                <br>
                virtio over mmio devices as a lightweight machine model
                for modern
                <br>
                cloud. The standard virtio over MMIO transport layer
                only supports one
                <br>
                legacy interrupt, which is much heavier than virtio over
                PCI transport
                <br>
                layer using MSI. Legacy interrupt has long work path and
                causes specific
                <br>
                VMExits in following cases, which would considerably
                slow down the
                <br>
                performance:
                <br>
                <br>
                1) read interrupt status register
                <br>
                2) update interrupt status register
                <br>
                3) write IOAPIC EOI register
                <br>
                <br>
                We proposed to add MSI support for virtio over MMIO via
                new feature
                <br>
                bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt
                performance.
                <br>
                <br>
                With the VIRTIO_F_MMIO_MSI feature bit supported, the
                virtio-mmio MSI
                <br>
                uses msi_sharing[1] to indicate the event and vector
                mapping.
                <br>
                Bit 1 is 0: device uses non-sharing and fixed vector per
                event mapping.
                <br>
                Bit 1 is 1: device uses sharing mode and dynamic
                mapping.
                <br>
              </blockquote>
              <br>
              <br>
              I believe dynamic mapping should cover the case of fixed
              vector?
              <br>
              <br>
            </blockquote>
            Actually this bit *aims* for msi sharing or msi non-sharing.
            <br>
            <br>
            It means, when msi sharing bit is 1, device doesn't want
            vector per queue
            <br>
            <br>
            (it wants msi vector sharing as name) and doesn't want a
            high interrupt rate.
            <br>
            <br>
            So driver turns to !per_vq_vectors and has to do dynamical
            mapping.
            <br>
            <br>
            So they are opposite not superset.
            <br>
            <br>
            Thanks!
            <br>
            <br>
            Jing
            <br>
          </blockquote>
          <br>
          <br>
          I think you need add more comments on the command.
          <br>
          <br>
          E.g if I want to map vector 0 to queue 1, how do I need to do?
          <br>
          <br>
          write(1, queue_sel);
          <br>
          write(0, vector_sel);
          <br>
        </blockquote>
        <br>
        That's true. Besides, two commands are used for msi sharing
        mode,
        <br>
        <br>
        VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and
        VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
        <br>
        <br>
        "To set up the event and vector mapping for MSI sharing mode,
        driver SHOULD write a valid MsiVecSel followed by
        VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
        command to map the configuration change/selected queue events
        respectively.=C2=A0 " (See spec patch 5/5)
        <br>
        <br>
        So if driver detects the msi sharing mode, when it does setup
        vq, writes the queue_sel (this already exists in setup vq),
        vector sel and then MAP_QUEUE command to do the queue event
        mapping.
        <br>
        <br>
      </blockquote>
      <br>
      So actually the per vq msix could be done through this. </blockquote>
    <p>Right, per vq msix can also be mapped by the 2 commands if we
      want.=C2=A0 <br>
    </p>
    <p>The current design benefits for those devices requesting per vq
      msi that driver</p>
    <p> doesn't have to map during setup each queue, <br>
    </p>
    <p>since we define the relationship by default.</p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">I don't
      get why you need to introduce MSI_SHARING_MASK which is the charge
      of driver instead of device. </blockquote>
    <p>MSI_SHARING_MASK is just for identifying the msi_sharing bit in
      readl(MsiState) (0x0c4). The device tells whether it wants
      msi_sharing.<br>
    </p>
    <p><span class=3D"fontstyle0">MsiState register: R<br>
      </span></p>
    <p><span class=3D"fontstyle0">le32 {<br>
        =C2=A0=C2=A0=C2=A0 msi_enabled : 1;<br>
        =C2=A0=C2=A0=C2=A0 msi_sharing: 1;<br>
        =C2=A0=C2=A0=C2=A0 reserved : 30;<br>
        };</span> <br style=3D" font-style: normal; font-variant: normal;
        font-weight: normal; letter-spacing: normal; line-height:
        normal; orphans: 2; text-align: -webkit-auto; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">The
      interrupt rate should have no direct relationship with whether it
      has been shared or not.
      <br>
    </blockquote>
    <br>
    <blockquote type=3D"cite"
      cite=3D"mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">
      <br>
      Btw, you introduce mask/unmask without pending, how to deal with
      the lost interrupt during the masking then?
      <br>
      <br>
      <br>
      <blockquote type=3D"cite">For msi non-sharing mode, no special
        action is needed because we make the rule of per_vq_vector and
        fixed relationship.
        <br>
        <br>
        Correct me if this is not that clear for spec/code comments.
        <br>
        <br>
      </blockquote>
      <br>
      The ABI is not as straightforward as PCI did. Why not just reuse
      the PCI layout?
      <br>
      <br>
      E.g having
      <br>
      <br>
      queue_sel
      <br>
      queue_msix_vector
      <br>
      msix_config
      <br>
      <br>
      for configuring map between msi vector and queues/config
      <br>
    </blockquote>
    <p>Thanks for the advice. :)</p>
    <p>Actually when looking into pci, the queue_msix_vector/msix_config
      is the msi vector index, which is the same as the mmio register
      MsiVecSel (0x0d0).</p>
    <p>So we don't introduce two extra registers for mapping even in
      sharing mode. <br>
    </p>
    <p>What do you think?<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">
      <br>
      Then
      <br>
      <br>
      vector_sel
      <br>
      address
      <br>
      data
      <br>
      pending
      <br>
      mask
      <br>
      unmask
      <br>
      <br>
      for configuring msi table?
      <br>
    </blockquote>
    <p>PCI-like msix table is not introduced to device and instead
      simply use commands to tell the mask/configure/enable.</p>
    <p>Thanks!</p>
    <p>Jing<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">
      <br>
      Thanks
      <br>
      <br>
      <br>
      <blockquote type=3D"cite">Thanks!
        <br>
        <br>
        Jing
        <br>
        <br>
        <br>
        <blockquote type=3D"cite">
          <br>
          ?
          <br>
          <br>
          Thanks
          <br>
          <br>
          <br>
          <blockquote type=3D"cite">
            <br>
            <br>
            <blockquote type=3D"cite">Thanks
              <br>
              <br>
              <br>
              <br>
---------------------------------------------------------------------
              <br>
              To unsubscribe, e-mail:
              <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:virtio-d=
ev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-ope=
n.org</a>
              <br>
              For additional commands, e-mail:
              <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:virtio-d=
ev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>
              <br>
              <br>
            </blockquote>
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------44FD458F3BC9286B8F433811--

