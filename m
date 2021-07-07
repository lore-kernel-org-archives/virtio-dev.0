Return-Path: <virtio-comment-return-1958-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <9e20bfca-2302-1cd4-d839-0a68aa1a1a31@redhat.com>
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <87eecbhai7.fsf@redhat.com>
 <9cf51717-9627-ce3e-07fe-85c80b8d0004@redhat.com>
 <8735srh5zu.fsf@redhat.com>
 <9e20bfca-2302-1cd4-d839-0a68aa1a1a31@redhat.com>
Date: Wed, 07 Jul 2021 18:45:58 +0200
Message-ID: <877di2f4xl.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH V2 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 07 2021, Jason Wang <jasowang@redhat.com> wrote:

> =E5=9C=A8 2021/7/6 =E4=B8=8B=E5=8D=8810:27, Cornelia Huck =E5=86=99=E9=81=
=93:
>> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>>
>>> =E5=9C=A8 2021/7/6 =E4=B8=8B=E5=8D=888:50, Cornelia Huck =E5=86=99=E9=
=81=93:
>>>> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>>> +If VIRTIO_F_STOP has been negotiated, to stop a device, after settin=
g
>>>>> +STOP, the driver MUST re-read the device status to ensure the STOP b=
it
>>>>> +is set to synchronize with the device.
>>>> Is this more that the driver needs to re-read the status until STOP is
>>>> set to make sure that the stop process has finished?
>>>
>>> Yes.
>>>
>>>
>>>>    If the device has
>>>> offered the feature and the driver accepted it, I'd assume that the
>>>> device will eventually finish with the procedure, or sets NEEDS_RESET =
if
>>>> something goes wrong?
>>>
>>> As stated below, the device must either:
>>>
>>> 1) finish all pending requests
>>>
>>> or
>>>
>>> 2) provide a device specific way for the driver to save and restore
>>> pending requests
>>>
>>> before setting STOP.
>>>
>>> Otherwise the device can't offer this feature.
>>>
>>> Using NEEDS_RESET seems more complicated than this.
>> Hm, what happens on an internal error?
>
>
> A question, can reset fail? If yes, do we need to define how to proceed=
=20
> in the driver side?
>
> If not, I don't need the reason we need to deal with that in the STOP.

When you put it that way, it makes sense. Let's just keep it simple,
then.


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

