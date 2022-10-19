Return-Path: <gerry@linux.alibaba.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
From: Gerry <gerry@linux.alibaba.com>
In-Reply-To: <36c27c6b-e8b5-5597-d1b0-c7fd3c3388dd@redhat.com>
Date: Wed, 19 Oct 2022 17:10:25 +0800
Message-Id: <44E44B6B-F979-425E-A63D-95D1AAA14435@linux.alibaba.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666146893.4959266-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsS1no70rcg_YHip1UYt+sFF2nTOBahvvi-e_VqL-NgJw@mail.gmail.com>
 <1666152510.9531486-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvHXp+NPxWYeSp_J8PYCT72GD9-jL3wYT6yC-6QxhMKFw@mail.gmail.com>
 <1666159341.0495708-1-xuanzhuo@linux.alibaba.com>
 <Y0+wRQ59IoWTs7h0@TonyMac-Alibaba>
 <36c27c6b-e8b5-5597-d1b0-c7fd3c3388dd@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> 2022=E5=B9=B410=E6=9C=8819=E6=97=A5 17:04=EF=BC=8CJason Wang <jasowang@re=
dhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> =E5=9C=A8 2022/10/19 16:07, Tony Lu =E5=86=99=E9=81=93:
>> On Wed, Oct 19, 2022 at 02:02:21PM +0800, Xuan Zhuo wrote:
>>> On Wed, 19 Oct 2022 12:36:35 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
>>>> On Wed, Oct 19, 2022 at 12:22 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
>>>>> On Wed, 19 Oct 2022 11:56:52 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
>>>>>> On Wed, Oct 19, 2022 at 10:42 AM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>>>>>>> On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>> Hi Jason,
>>>>>>>=20
>>>>>>> I think there may be some problems with the direction we are discus=
sing.
>>>>>> Probably not.
>>>>>>=20
>>>>>> As far as we are focusing on technology, there's nothing wrong from =
my
>>>>>> perspective. And this is how the community works. Your idea needs to
>>>>>> be justified and people are free to raise any technical questions
>>>>>> especially considering you've posted a spec change with prototype
>>>>>> codes but not only the idea.
>>>>>>=20
>>>>>>> Our
>>>>>>> goal is to add an new ism device. As far as the spec is concerned, =
we are not
>>>>>>> concerned with the implementation of the backend.
>>>>>>>=20
>>>>>>> The direction we should discuss is what is the difference between t=
he ism device
>>>>>>> and other devices such as virtio-net, and whether it is necessary t=
o introduce
>>>>>>> this new device.
>>>>>> This is somehow what I want to ask, actually it's not a comparison
>>>>>> with virtio-net but:
>>>>>>=20
>>>>>> - virtio-roce
>>>>>> - virtio-vhost-user
>>>>>> - virtio-(p)mem
>>>>>>=20
>>>>>> or whether we can simply add features to those devices to achieve wh=
at
>>>>>> you want to do here.
>>>>>=20
>>>>> Yes, this is my priority to discuss.
>>>>>=20
>>>>> At the moment, I think the most similar to ism is the Vhost-user Devi=
ce Backend
>>>>> of virtio-vhost-user.
>>>>>=20
>>>>> My understanding of it is to map any virtio device to another vm as a=
 vvu
>>>>> device.
>>>> Yes, so a possible way is to have a device with memory zone/region
>>>> provision and management then map it via virtio-vhost-user.
>>>=20
>>> Yes, there is such a possibility. virtio-vhost-user makes me feel that =
what can
>>> be shared is the function implementation of map.
>>>=20
>>> But in the vm to provide the interface to the upper layer, I think this=
 is the
>>> work of ism.
>>>=20
>>> But one of the reasons why I didn't use virtio-vhost-user directly is t=
hat in
>>> another vm, the guest can operate the vvu device, which we hope that bo=
th sides
>>> are equal to the ism device.
>>>=20
>>> So I want to agree on a question first: who will provide the upper laye=
r with
>>> the ability to share the memory area?
>>>=20
>>> Our answer is a new ism device. How does this device achieve memory sha=
ring, I
>>> think is the second question.
>>>=20
>>>=20
>>>>> From this design purpose, I think the two are different.
>>>>>=20
>>>>> Of course, you might want to extend it, it does have some similaritie=
s and uses
>>>>> a lot of similar techniques.
>>>> I don't have any preference so far. If you think your idea makes more
>>>> sense, then try your best to justify it in the list.
>>>>=20
>>>>> So we can really discuss in this direction, whether
>>>>> the vvu device can be extended to achieve the purpose of ism, or whet=
her the
>>>>> design goals can be agreed.
>>>> I've added Stefan in the loop, let's hear from him.
>>>>=20
>>>>> Or, in the direction of memory sharing in the backend, can ism and vv=
u be merged?
>>>>> Should device/driver APIs remain independent?
>>>> Btw, you mentioned that one possible user of ism is the smc, but I
>>>> don't see how it connects to that with your prototype driver.
>>> Yes, we originally had plans, but the virtio spec was considered for su=
bmission,
>>> so this was not included. Maybe, we should have included this part @Ton=
y
>>>=20
>>> A brief introduction is that SMC currently has a corresponding
>>> s390/net/ism_drv.c and we will replace this in the virtualization scena=
rio.
>=20
>=20
> Ok, I see. So I think the goal is to implement something in virtio that i=
s functional equivalent to IBM ISM device.
>=20
>=20
>>>=20
>>> Thanks.
>>>=20
>> SMC is a network protocol which is modeled by shared memory rather than
>> packet.
>=20
>=20
> After reading more SMC from IBM website, I think you meant SMC-D here. An=
d I wonder in order to have a complete SMC solution we still need virtio-RO=
CE for inter host communcation?
Absolutely, a complete solution includes SMC-R remote peers and SMC-D for l=
ocal peers:)


>=20
>>  Actually the basic required interfaces of SMC device are:
>>=20
>>   - alloc / free memory region, each connection peer has two memory
>> =09regions dynamically for sending and receiving ring buffer.
>>   - attach / detach memory region, remote attaches local-allocated
>> =09sending region as receiving region, vice versa.
>>   - notify, tell peer to read data and update cursor.
>>=20
>> Then the device can be registered as SMC ISM device. Of course, SMC
>> also requires some modification to adapt it.
>=20
>=20
> Looking at s390 ism driver it requires other stuffs like vlan add/remove =
or gid query, do we need them as well?
We plan to get rid of vlan support, but we do need interface to query gid e=
tc.
And the virtio-queue helps us much to implement a control communication cha=
nnel to support those operations.

>=20
> Thanks
>=20
>=20
>>=20
>> Cheers,
>> Tony Lu
>>=20
>>>> Thanks
>>>>=20
>>>>> Thanks.
>>>>>=20
>>>>>=20
>>>>>>> How to share the backend with other deivce is another problem.
>>>>>> Yes, anything that is used for your virito-ism prototype can be used
>>>>>> for other devices.
>>>>>>=20
>>>>>>> Our goal is to dynamically obtain a piece of memory to share with o=
ther vms.
>>>>>> So at this level, I don't see the exact difference compared to
>>>>>> virtio-vhost-user. Let's just focus on the API that carries on the
>>>>>> semantic:
>>>>>>=20
>>>>>> - map/unmap
>>>>>> - permission update
>>>>>>=20
>>>>>> The only missing piece is the per region notification.
>>>>>>=20
>>>>>>> In a connection, this memory will be used repeatedly. As far as SMC=
 is concerned,
>>>>>>> it will use it as a ring. Of course, we also need a notify mechanis=
m.
>>>>>>>=20
>>>>>>> That's what we're aiming for, so we should first discuss whether th=
is
>>>>>>> requirement is reasonable.
>>>>>> So unless somebody said "no", it is fine until now.
>>>>>>=20
>>>>>>> I think it's a feature currently not supported by
>>>>>>> other devices specified by the current virtio spce.
>>>>>> Probably, but we've already had rfcs for roce and vhost-user.
>>>>>>=20
>>>>>> Thanks
>>>>>>=20
>>>>>>> Thanks.
>>>>>>>=20
>>>>>>>=20

