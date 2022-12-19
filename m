Return-Path: <virtio-comment-return-3588-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <5f88a64d-bca1-7039-d257-169621f813bd@linux.alibaba.com>
Date: Mon, 19 Dec 2022 10:52:23 +0800
MIME-Version: 1.0
References: <20221205063639.127767-1-hengqi@linux.alibaba.com>
 <20221216074415-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20221216074415-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [PATCH v3] virtio_net: support inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2022/12/16 =E4=B8=8B=E5=8D=888:49, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> On Mon, Dec 05, 2022 at 02:36:39PM +0800, Heng Qi wrote:
>> @@ -4005,6 +4159,24 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>>   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>   \end{lstlisting}
>>  =20
>> +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
>> +\field{hash_report_tunnel} can report the type of the tunnel-encapsulat=
ed
>> +packet to the driver over the inner header hash calculation.
>> +Possible values that the device can report in \field{hash_report_tunnel=
}
>> +are defined below:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_NET_HASH_REPORT_GRE             1
>> +#define VIRTIO_NET_HASH_REPORT_VXLAN           2
>> +#define VIRTIO_NET_HASH_REPORT_GENEVE          3
>> +\end{lstlisting}
>> +
>> +The values VIRTIO_NET_HASH_REPORT_GRE, VIRTIO_NET_HASH_REPORT_VXLAN and
>> +VIRTIO_NET_HASH_REPORT_GENEVE correspond to VIRTIO_NET_HASH_TYPE_GRE_IN=
NER,
>> +VIRTIO_NET_HASH_TYPE_VXLAN_INNER and VIRTIO_NET_HASH_TYPE_GENEVE_INNER =
bits
>> +of supported hash types defined in respectively
>> +\ref{sec:Device Types / Network Device / Device Operation / Processing =
of Incoming Packets / Hash calculation for incoming packets / Supported/ena=
bled hash types}.
>> +
>>   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Dev=
ice / Device Operation / Control Virtqueue}
>>  =20
>>   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> If the new feature flag is negotiated, we need to spell out more clearly =
what are the rules
> for packets that are not encapsulated. Is hash_report_tunnel set to 0

Yes, we should. When the _TUNNEL feature is negotiated, for=20
non-encapsulated packets we set \field{hash_report_tunnel} to 0.

> then? Another comment is that we keep repeating GRE/VXLAN/GENEVE too
> many times. Let's add a paragraph defining a concept e.g. a "tunnel" or
> "tunneled packets", explaining how they are handled at a high level,
> and then just refer to the tunnel everywhere.
> Let's also add external references to specifications documenting the
> relevant tunnel types.

Ok, I'll try to make this clear.

Thanks.

>
>
>> --=20
>> 2.19.1.6.gb485710b


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

