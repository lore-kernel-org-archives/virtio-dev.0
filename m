Return-Path: <virtio-dev-return-10277-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D1A39864B2
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 Nov 2022 10:37:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <4fdaf9b6-46e3-c56d-309c-0208d1c6eaf7@redhat.com>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-2-mst@redhat.com>
 <CACGkMEtk6YLic7zjDj-yd36piLSjx5h18eXYs4rKD=uKdqprzw@mail.gmail.com>
 <20221124015254-mutt-send-email-mst@kernel.org>
 <CACGkMEuxYxXU+bYGh79=-KzRRKA-hTvEkTbxej7c=8dB_Q_jZA@mail.gmail.com>
 <20221124031018-mutt-send-email-mst@kernel.org>
 <87k03kh80p.fsf@redhat.com>
 <4fdaf9b6-46e3-c56d-309c-0208d1c6eaf7@redhat.com>
Date: Fri, 25 Nov 2022 11:37:05 +0100
Message-ID: <87zgcfgw1a.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v9 01/10] virtio: document forward compatibility guarantees
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 25 2022, Jason Wang <jasowang@redhat.com> wrote:

> =E5=9C=A8 2022/11/24 20:05, Cornelia Huck =E5=86=99=E9=81=93:
>> On Thu, Nov 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Thu, Nov 24, 2022 at 03:34:19PM +0800, Jason Wang wrote:
>>>> On Thu, Nov 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>>>>> On Thu, Nov 24, 2022 at 12:33:52PM +0800, Jason Wang wrote:
>>>>>> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>>> Feature negotiation forms the basis of forward compatibility
>>>>>>> guarantees of virtio but has never been properly documented.
>>>>>>> Do it now.
>>>>>>>
>>>>>>> Suggested-by: Halil Pasic <pasic@linux.ibm.com>
>>>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>> ---
>>>>>>>   content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>   1 file changed, 42 insertions(+)
>>>>>>>
>>>>>>> diff --git a/content.tex b/content.tex
>>>>>>> index 3051399..e3203be 100644
>>>>>>> --- a/content.tex
>>>>>>> +++ b/content.tex
>>>>>>> @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facili=
ties of a Virtio Device / Feature B
>>>>>>>   In particular, new fields in the device configuration space are
>>>>>>>   indicated by offering a new feature bit.
>>>>>>>
>>>>>>> +To keep te feature negotiation mechanism extensible, it is importa=
nt
>>>>>>> +that devices \em{do not} offer any feature bits that they would no=
t be
>>>>>>> +able to handle if the driver accepted them (even though drivers ar=
e not
>>>>>>> +supposed to accept them in the first place even if offered, accord=
ing to
>>>>>>> +this version of the specification.)
>>>>>> It looks to me if we want to clarify like this, feature negotiation =
is
>>>>>> not sufficient. Do we need to do something similar in other basic
>>>>>> facilities? Generally, we probably need to do this for facilities th=
at
>>>>>> are similar to features (status, virtqueue size and others).
>>>>> I'm not sure about "not sufficient". It's sufficient as long
>>>>> as you just want to extend features. What triggered this
>>>>> work is adding a transport specific feature.
>>>> E.g:
>>>>
>>>> For status: Devices do not offer any status bit it would not be able t=
o handle.
>>>> For virtqueue size:  Devices do not offer virtqueue size it would not
>>>> be able to handle.
>>>>
>>>> ?
>>> Jason I think what you miss here is this part:
>>>
>>> "even though drivers are not
>>> supposed to accept them in the first place even if offered, according t=
o
>>> this version of the specification"
>>>
>>> does not apply to status and virtqueue size.
>>>
>>>
>>> Let me clarify what all this means.
>>> It seems safe for a device to offer a reserved feature bit
>
>
> This depends really on the behaviour of the drivers.
>
>
>>> since drivers are not supposed to accept it.
>
>
> So this is the case of the ADMIN_VQ.
>
>
>>> This text says device must not rely on this.
>>>
>>> How would this apply to status or vq size? I don't see.
>> Me neither... for the status, it's about either the driver noting its
>> progress, or the device indicating that a reset is needed. The only case
>> where setting something requires kind of an ack is FEATURES_OK, and
>> there we already spell out the conditions clearly.
>
>
> I basically meant something like:
>
> Assuming we have a feature like VIRTIO_RING_F_NEW and a new status bit=20
> was mapped to this feature, VIRTIO_CONFIG_S_NEW. And for some reason=20
> this feature is reserved for some transports. Should we mention device=20
> does not offer VIRTIO_CONFIG_S_NEW as well, or we assume it is implied=20
> that we don't offer VIRTIO_CONFIG_S_NEW in this case?

I'm not sure that adding a feature-specific status bit would make sense,
given that the status bits either need to work before feature
negotiation is complete, or are actually needed for feature negotiation.
Also, the status-bit space is way more limited than the feature-bit
space. Therefore, I think we can safely ignore the status bits.

>
>
>> For the queue size,
>> we specify that the device states what it can support, and that the
>> driver may only reduce it, that seems clear enough to me.
>
>
> Similar to the above, assuming a feature VIRTIO_R_F_MAXSIZE_XXX, and it=
=20
> is reserved. Should we mention that the new max virtqueue size should=20
> not be advertised or it is implied in the feature advertisement?

I'd say it's implied in the feature bit handling already.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

