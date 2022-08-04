Return-Path: <virtio-dev-return-9699-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A10898658D
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 Aug 2022 13:50:22 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <8ab46a3e-8f00-e05f-0dca-d0009164aa16@linux.alibaba.com>
References: <1659337182-128890-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.com>
 <8ab46a3e-8f00-e05f-0dca-d0009164aa16@linux.alibaba.com>
Date: Thu, 04 Aug 2022 15:50:16 +0200
Message-ID: <87bkt086ef.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH] virtio_net: support split header
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 04 2022, Heng Qi <hengqi@linux.alibaba.com> wrote:

> =E5=9C=A8 2022/8/4 =E4=B8=8B=E5=8D=882:27, Jason Wang =E5=86=99=E9=81=93:
>> On Mon, Aug 1, 2022 at 2:59 PM Heng Qi<hengqi@linux.alibaba.com>  wrote:
>>> @@ -3820,9 +3826,13 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
>>>   driver MUST NOT use the \field{csum_start} and \field{csum_offset}.
>>>
>>>   If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 option=
s have
>>> -been negotiated, the driver MAY use \field{hdr_len} only as a hint abo=
ut the
>>> +been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{fl=
ags}
>>> +is not set, the driver MAY use \field{hdr_len} only as a hint about th=
e
>>>   transport header size.
>>> -The driver MUST NOT rely on \field{hdr_len} to be correct.
>>> +
>>> +If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is not set, =
the driver
>>> +MUST NOT rely on \field{hdr_len} to be correct.
>> I think we should keep the above description as-is. For whatever case,
>> the driver must not trust the metadata set by the device and must
>> perform necessary sanity tests on them.
>
>
> My idea is to keep the current description as it is,
> but to emphasize in the next version:
> "If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set,
> the driver MAY treat the \field{hdr_len} as the length of the
> protocol header inside the first descriptor."


Just to be clear, you suggest using

"If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options hav=
e
been negotiated, the driver MAY use \field{hdr_len} only as a hint about th=
e
transport header size.

The driver MUST NOT rely on \field{hdr_len} to be correct.

If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set,
the driver MAY treat the \field{hdr_len} as the length of the
protocol header inside the first descriptor."

(Maybe "...the driver MAY use \field{hdr_len} as a hint about the length
of the protocol header..."? It's still not reliable, right?)

>
>
>>
>>> +
>>>   \begin{note}
>>>   This is due to various bugs in implementations.
>>>   \end{note}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

