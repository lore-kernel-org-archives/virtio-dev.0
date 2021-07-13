Return-Path: <virtio-comment-return-1977-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com> <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
Date: Tue, 13 Jul 2021 10:19:32 +0200
Message-ID: <875yxeeicr.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 13 2021, Jason Wang <jasowang@redhat.com> wrote:

> =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
>> When migrating a guest with many VIRTIO devices a busy waiting approach
>> extends downtime if implemented sequentially (stopping one device at a
>> time).
>
>
> Well. You need some kinds of waiting for sure, the device/DMA needs=20
> sometime to be stopped. The downtime is determined by a specific virtio=
=20
> implementation which is hard to be restricted at the spec level. We can=
=20
> clarify that the device must set the STOP bit in e.g 100ms.

I don't think we can introduce arbitrary upper bounds here. At most, we
can say that the device SHOULD try to set the STOP bit as early as
possible (and make use of the mechanism to expose in-flight buffers.)

If we want to avoid polling for the STOP bit, we need some kind of
notification mechanism, I guess. For ccw, I'd just use a channel
command to stop the device; completion of that channel program would
indicate that the device is done with the stop procedure. Not sure how
well that translates to other transports.


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

