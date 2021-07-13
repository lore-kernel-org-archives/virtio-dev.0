Return-Path: <virtio-comment-return-1984-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com> <875yxeeicr.fsf@redhat.com>
 <c395dbb0-f087-15df-a315-9a8da34f6e55@redhat.com> <8735sie9g1.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <52f45a4e-16fb-f8c9-00a4-0a7947dcb1c5@redhat.com>
Date: Tue, 13 Jul 2021 20:23:08 +0800
MIME-Version: 1.0
In-Reply-To: <8735sie9g1.fsf@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=887:31, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Tue, Jul 13 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=884:19, Cornelia Huck =E5=86=99=E9=
=81=93:
>>> On Tue, Jul 13 2021, Jason Wang <jasowang@redhat.com> wrote:
>>>
>>>> =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
>>>>> When migrating a guest with many VIRTIO devices a busy waiting approa=
ch
>>>>> extends downtime if implemented sequentially (stopping one device at =
a
>>>>> time).
>>>> Well. You need some kinds of waiting for sure, the device/DMA needs
>>>> sometime to be stopped. The downtime is determined by a specific virti=
o
>>>> implementation which is hard to be restricted at the spec level. We ca=
n
>>>> clarify that the device must set the STOP bit in e.g 100ms.
>>> I don't think we can introduce arbitrary upper bounds here. At most, we
>>> can say that the device SHOULD try to set the STOP bit as early as
>>> possible (and make use of the mechanism to expose in-flight buffers.)
>>
>> Yes, that's my understanding.
>>
>>
>>> If we want to avoid polling for the STOP bit, we need some kind of
>>> notification mechanism, I guess. For ccw, I'd just use a channel
>>> command to stop the device; completion of that channel program would
>>> indicate that the device is done with the stop procedure.
>>
>> A question, is interrupt used for such notification, or the VMM can
>> choose to poll for the completion?
> You can poll for the subchannel to become status pending.
>
>>
>>> Not sure how
>>> well that translates to other transports.
>>
>> Actually, it's not necessarily a busy polling. VMM can schedule other
>> process in and recheck the bit periodically.
>>
>> Or as you mentioned before, we can use some kind of interrupt but it
>> would be more complicated than the simple status bit. It's better to
>> introduce the interrupt only if the status bit doesn't fit.
> At least for ccw, waiting for the status bit to be set also involves an
> interrupt or polling (we use another channel program to retrieve the
> status.) A dedicated channel command would actually be better, as the
> interrupt/status pending would already inform us of success.


So it looks to me it doesn't conflict with this design: the device must=20
wait for the device to be stopped to signal the success of the ccw command?

Thanks


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

