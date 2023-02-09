Return-Path: <virtio-comment-return-4078-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <35a7c212-cab4-7906-99a1-1504ef3692c3@linux.alibaba.com>
Date: Thu, 9 Feb 2023 11:25:10 +0800
MIME-Version: 1.0
References: <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230208154819-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing
 moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/9 =E4=B8=8A=E5=8D=884:52, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Wed, Feb 08, 2023 at 07:53:09PM +0200, Alvaro Karsz wrote:
>>   > > From: Michael S. Tsirkin <mst@redhat.com>
>>>> Sent: Wednesday, February 8, 2023 9:48 AM
>>>>
>>>> On Wed, Feb 08, 2023 at 02:44:37PM +0000, Parav Pandit wrote:
>>>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>>>> Sent: Wednesday, February 8, 2023 9:43 AM
>>>>>>
>>>>>> On Wed, Feb 08, 2023 at 02:37:55PM +0000, Parav Pandit wrote:
>>>>>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>>>>>> Sent: Wednesday, February 8, 2023 9:18 AM
>>>>>>>>
>>>>>>>> On Wed, Feb 08, 2023 at 07:30:34PM +0800, Heng Qi wrote:
>>>>>>>>>> I see two options.
>>>>>>>>>> 1. Just have per VQ params. Software has the full knowledge
>>>>>>>>>> of in which it is
>>>>>>>> operating, and state remains at software level.
>>>>>>>>>> This effectively achieves both the mode.
>>>>>>>>>>
>>>>>>>>>> 2. Have a mode cmd,
>>>>>>>>>> Mode =3D (a) per device or (b) per VQ (c) disable After the
>>>>>>>>>> mode is set, driver can set per device or per VQ.
>>>>>>>>> I find this more clear.
>>>>>>>>>
>>>>>>>>> Thanks.
>>>>>>>>>
>>>>>>>> Rereading this I think I misunderstood the proposal.
>>>>>>>> Now we are burning memory on maintaining mode, and this
>>>>>>>> information is duplicated.
>>>>>>>>
>>>>>>> It is not maintained in the pci resident memory, so it doesn't hurt=
.
>>>>>>>
>>>>>>>> I'd say let's just add a new command COAL_QUEUE_SET with vqn as
>>>>>> parameter.
>>>>>>>> Existing commands are simply defined as a shortcut to running
>>>>>>>> COAL_QUEUE_SET on all tx/rx queues respectively.
>>>>>>>>
>>>>>>>> Latest command dictates the parameters. To disable just set
>>>>>>>> everything to 0 (btw we should make this explicit in the spec,
>>>>>>>> but it can be
>>>>>> guessed from:
>>>>>>>> Upon reset, a device MUST initialize all coalescing parameters to =
0.
>>>>>>>> )
>>>>>>>>
>>>>>>> Switching between the modes (per q vs per device) implicitly is
>>>>>>> ambiguous
>>>>>> and it only means device may need to iterate.
>>>>>>
>>>>>> hmm i feel it's only ambiguous because i failed to explain in well.
>>>>>>
>>>>>>> This state is either better maintained in sw by always having per
>>>>>>> vq or have
>>>>>> clearly defined mode of what device should do.
>>>>>>> Per Q is very common even for several years old devices.
>>>>>>> Last time I counted, there were at least 15 such devices supporting=
 it.
>>>>>>>
>>>>>>> So actual usage wise, I practically see that most implementations
>>>>>>> will end up
>>>>>> with per vq mode.
>>>>>>> I like to hear from Heng or Alvaro if they see any use of per devic=
e.
>>>>>>
>>>>>> Right so given this, most devices will be in per queue mode all the
>>>>>> time. why do you want a mode then? just keep per queue.
>>>>>> existing commands are kept around for compat but internally just
>>>>>> translate to per-queue.
>>>>> Since the space is not released, do we need to keep the compat?
>>>> It's been accepted for half a year so we can't say for sure no one bui=
lt this.
>>> That is likely but we should have the ability to have the Errata/ECN to=
 correct it, specially for unrelease spec.
>>>
>>>> The way I propose is just a bit of firmware on device that scans all q=
ueues and
>>>> copies same parameters everywhere.
>>> This scanning loop in sw appears cheaper to me than some embedded fw.
>>> But is not a lot of concern.
>>>
>>>> Seems easier than worrying about this,
>>>> and we get disabling coalescing for free which you wanted. With an ext=
ra mode
>>>> its extra logic in the device fast path. Maybe it's cheap on hardware =
side but in
>>>> software it's an extra branch, not free.
>>> Most performant data path wouldn't implement and read the extra mode.
>>> It is always fw that is going to program same value, or per queue value=
d or disable value in each Q regardless whichever way we craft the CVQ cmd.
>>>
>>> The sequence that bothers me is below.
>>> 1. driver set global params
>>> 2. few minutes later, now driver set param for Q=3D1
>>>
>>> On this command, a device need to decide:
>>> Should Q =3D 2 to N
>>> (a) either work with previous globals, or
>>> (b) because per Q was set for one queue, they rest of the queues implic=
itly disable it.
>>>
>>> If it is (b),
>>> When a command on Q object =3D1 is issued, it affects other Q objects. =
<- This I want to avoid.
>>> A cmd that modifies the object, should only modify that object.
>>>
>>> If it is (a), it is mixed mode operation, which is ambiguous definition=
.
>>>
>>> A better semantic is to define such change at device level and no extra=
 cost in the data path.
>> I think that (a) is the way to go.
>> I don't think that we should work with operation modes at all.
>>
>> In my opinion:
>>
>> We should have 2 features:
>> VIRTIO_NET_F_PERQUEUE_NOTF_COAL and VIRTIO_NET_F_NOTF_COAL.
>>
>> VIRTIO_NET_F_PERQUEUE_NOTF_COAL sets per queue parameters, and
>> VIRTIO_NET_F_NOTF_COAL sets parameters for all queues.
>>
>> VIRTIO_NET_F_NOTF_COAL has 2 commands:
>>      VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
>>      VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
>>
>> VIRTIO_NET_F_PERQUEUE_NOTF_COAL has 2 commands:
>>      VIRTIO_NET_CTRL_NOTF_COAL_PER_QUEUE_TX_SET
>>      VIRTIO_NET_CTRL_NOTF_COAL_PER_QUEUE_RX_SET
>>
>> We can see VIRTIO_NET_CTRL_NOTF_COAL_RX_SET as a virtio level shortcut
>> for setting all queues with one command, exactly as intended with
>> rx_qid=3D 0xFFFF, and without breaking devices following the current
>> spec.
>>
>> The device's FW can decide if it stores parameters received with
>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET in a global set, or if it iterates
>> through all queues, but IMO the best way it to iterate through all
>> queues.
>>
>> Seems like a win-win situation to me.
>> We achieve the same functionality as described in the patch, but
>> without breaking devices following the current spec.
>>
>> Now, if we follow this method,
>> VIRTIO_NET_CTRL_NOTF_COAL_PER_QUEUE_RX_SET with rx_qid=3D 0xFFF seems
>> redundant.
>> If VIRTIO_NET_F_PERQUEUE_NOTF_COAL requires VIRTIO_NET_F_NOTF_COAL, a
>> device supporting VIRTIO_NET_F_PERQUEUE_NOTF_COAL can achieve the same
>> functionality with the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command.
> Yes. Just some comments:
>
> - I don't think we need two commands. We have RX and TX because we
>    did not have vq number previously. No we do so just pass that.
>    It's also clearer since struct name can match command exactly.

Yes, I believe I got your point yesterday.

>
> - Once we do that we can use a short _VQ_ instead of the wordy "PER_QUEUE=
".

This seems clearer and more straightforward.

> - Accordingly a well understood "vqn" instead of our own "qid" which
>    we then need to define.

Sure.

Thanks.

>
> - And yes no need for a reserved "qid" - it's a distinct command.
>


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

