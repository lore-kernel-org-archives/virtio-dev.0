Return-Path: virtio-dev-return-4525-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0EB5A58191F6
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Jun 2018 10:54:21 -0700 (PDT)
References: <20180620170904-mutt-send-email-mst@kernel.org>
 <20180620180619.6b4ee52d.cohuck@redhat.com>
 <20180620224535-mutt-send-email-mst@kernel.org>
 <20180621165913.7e3f4faa.cohuck@redhat.com>
 <CADGSJ22B39JiS14L0yCYQ720-fZcwyUt1wCX1YO-6Y9FhmDKZg@mail.gmail.com>
 <20180622053141-mutt-send-email-mst@kernel.org>
 <CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
 <CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
 <20180623002628-mutt-send-email-mst@kernel.org>
 <CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
 <20180623012406-mutt-send-email-mst@kernel.org>
 <CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
 <CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <da144f8f-65cd-45d9-3c81-6c8ca1fb25fe@intel.com>
Date: Mon, 25 Jun 2018 10:54:09 -0700
MIME-Version: 1.0
In-Reply-To: <CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Siwei Liu <loseweigh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 6/22/2018 5:17 PM, Siwei Liu wrote:
> On Fri, Jun 22, 2018 at 4:40 PM, Siwei Liu <loseweigh@gmail.com> wrote:
>> On Fri, Jun 22, 2018 at 3:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Fri, Jun 22, 2018 at 02:51:11PM -0700, Siwei Liu wrote:
>>>> On Fri, Jun 22, 2018 at 2:29 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> On Fri, Jun 22, 2018 at 01:03:04PM -0700, Siwei Liu wrote:
>>>>>> On Fri, Jun 22, 2018 at 1:00 PM, Siwei Liu <loseweigh@gmail.com> wrote:
>>>>>>> On Thu, Jun 21, 2018 at 7:32 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>>> On Thu, Jun 21, 2018 at 06:21:55PM -0700, Siwei Liu wrote:
>>>>>>>>> On Thu, Jun 21, 2018 at 7:59 AM, Cornelia Huck <cohuck@redhat.com> wrote:
>>>>>>>>>> On Wed, 20 Jun 2018 22:48:58 +0300
>>>>>>>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>>> On Wed, Jun 20, 2018 at 06:06:19PM +0200, Cornelia Huck wrote:
>>>>>>>>>>>> In any case, I'm not sure anymore why we'd want the extra uuid.
>>>>>>>>>>> It's mostly so we can have e.g. multiple devices with same MAC
>>>>>>>>>>> (which some people seem to want in order to then use
>>>>>>>>>>> then with different containers).
>>>>>>>>>>>
>>>>>>>>>>> But it is also handy for when you assign a PF, since then you
>>>>>>>>>>> can't set the MAC.
>>>>>>>>>>>
>>>>>>>>>> OK, so what about the following:
>>>>>>>>>>
>>>>>>>>>> - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
>>>>>>>>>>    that we have a new uuid field in the virtio-net config space
>>>>>>>>>> - in QEMU, add a property for virtio-net that allows to specify a uuid,
>>>>>>>>>>    offer VIRTIO_NET_F_STANDBY_UUID if set
>>>>>>>>>> - when configuring, set the property to the group UUID of the vfio-pci
>>>>>>>>>>    device
>>>>>>>>> If feature negotiation fails on VIRTIO_NET_F_STANDBY_UUID, is it safe
>>>>>>>>> to still expose UUID in the config space on virtio-pci?
>>>>>>>>
>>>>>>>> Yes but guest is not supposed to read it.
>>>>>>>>
>>>>>>>>> I'm not even sure if it's sane to expose group UUID on the PCI bridge
>>>>>>>>> where the corresponding vfio-pci device attached to for a guest which
>>>>>>>>> doesn't support the feature (legacy).
>>>>>>>>>
>>>>>>>>> -Siwei
>>>>>>>> Yes but you won't add the primary behind such a bridge.
>>>>>>> I assume the UUID feature is a new one besides the exiting
>>>>>>> VIRTIO_NET_F_STANDBY feature, where I think the current proposal is,
>>>>>>> if UUID feature is present and supported by guest, we'll do pairing
>>>>>>> based on UUID; if UUID feature present
>>>>>>                                   ^^^^^^^  is NOT present
>>>>> Let's go back for a bit.
>>>>>
>>>>> What is wrong with matching by mac?
>>>>>
>>>>> 1. Does not allow multiple NICs with same mac
>>>>> 2. Requires MAC to be programmed by host in the PT device
>>>>>     (which is often possible with VFs but isn't possible with all PT
>>>>>     devices)
>>>> Might not neccessarily be something wrong, but it's very limited to
>>>> prohibit the MAC of VF from changing when enslaved by failover.
>>> You mean guest changing MAC? I'm not sure why we prohibit that.
>> I think Sridhar and Jiri might be better person to answer it. My
>> impression was that sync'ing the MAC address change between all 3
>> devices is challenging, as the failover driver uses MAC address to
>> match net_device internally.

Yes. The MAC address is assigned by the hypervisor and it needs to manage the movement
of the MAC between the PF and VF.  Allowing the guest to change the MAC will require
synchronization between the hypervisor and the PF/VF drivers. Most of the VF drivers
don't allow changing guest MAC unless it is a trusted VF.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

