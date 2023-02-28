Return-Path: <virtio-comment-return-4582-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <0fca572e-6592-7d64-7d41-62c0220f22bd@linux.alibaba.com>
Date: Tue, 28 Feb 2023 16:10:38 +0800
MIME-Version: 1.0
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
 <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com>
 <CAJs=3_DND7WdoXc19XzOKDDKYNXFKdKRMr6j93p9z7=5EyGHGQ@mail.gmail.com>
 <20230227151420-mutt-send-email-mst@kernel.org>
 <46d5248b-1632-22b1-03b0-7ca64d536f04@linux.alibaba.com>
 <20230228024829-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230228024829-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v9] virtio-net:
 support the virtqueue coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/28 =E4=B8=8B=E5=8D=883:49, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Tue, Feb 28, 2023 at 10:41:18AM +0800, Heng Qi wrote:
>>> The problem is the global qualifier. And it's not even global -
>>> there are two sets for rx and for tx and does not apply to cvq at all.
>>> How about "RX/TX coalescing parameters"?
>> As Parav suggested, we probably don't need to mention "global
>> values/coalescing parameters" since this values/parameters are the ones =
set
>> by CTRL_NOTF_COAL_RX/TX_SET.
>>
>> Just like this:
>> "
>> After disabling and re-enabling a virtuqueue, the device MUST revert to
>> coalescing parameters to the one configured using VIRTIO_NET_CTRL_NOTF_C=
OAL.
>> "
>>
>> Thanks.
> VIRTIO_NET_CTRL_NOTF_COAL is not a thing. Let's wait for Alvaro's new
> patch to be merged though, see what teminology he comes up with and
> reuse.

Ok, are you referring to Alvaro's "virtio-net: Fix and update=20
VIRTIO_NET_F_NOTF_COAL feature",
if so I see that his v7 version is stable and has been voted in=20
https://github.com/oasis-tcs/ virtio-spec/issues/159 ,
this patch was made on top of his v7 version.

Thanks.



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

