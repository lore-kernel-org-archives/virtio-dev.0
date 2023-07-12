Return-Path: <virtio-dev-return-13353-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E32EB64D9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 13:25:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8513C68468
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 13:25:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6823B9867B0
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 13:25:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 48C76986682; Wed, 12 Jul 2023 13:25:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 354D9986686
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2023 13:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9gBkNt0JODaJMi7lR6tttg-1
From: Cornelia Huck <cohuck@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
In-Reply-To: <e0e2b21d-a7f9-fbf1-7d93-d142c7a7618a@linux.alibaba.com>
Organization: Red Hat GmbH
References: <20230703152711.106008-1-hengqi@linux.alibaba.com>
 <87pm4xjp4t.fsf@redhat.com>
 <20230712082508-mutt-send-email-mst@kernel.org>
 <87jzv5jo82.fsf@redhat.com>
 <e0e2b21d-a7f9-fbf1-7d93-d142c7a7618a@linux.alibaba.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 12 Jul 2023 15:25:14 +0200
Message-ID: <87h6q9jm85.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v21] virtio-net: support inner
 header hash

On Wed, Jul 12 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:

> =E5=9C=A8 2023/7/12 =E4=B8=8B=E5=8D=888:42, Cornelia Huck =E5=86=99=E9=81=
=93:
>> On Wed, Jul 12 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Wed, Jul 12, 2023 at 02:22:26PM +0200, Cornelia Huck wrote:
>>>> On Mon, Jul 03 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>
>>>> (...)
>>>>
>>>>> +\paragraph{Inner Header Hash}
>>>>> +\label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Inner Header Hash}
>>>>> +
>>>>> +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send=
 the command
>>>>> +VIRTIO_NET_CTRL_HASH_TUNNEL_SET to configure the calculation of the =
inner header hash.
>>>>> +
>>>>> +struct virtnet_hash_tunnel {
>>>>> +    le32 enabled_tunnel_types;
>>>>> +};
>>>>> +
>>>>> +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7
>>>>> + #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
>>>> This needs to be wrapped in \begin{lstlisting}..\end{lstlisting}, can =
do
>>>> so when applying.
>>>>
>>>> (...)
>>>>
>>>>> +Encapsulation types applicable for inner header hash:
>>>>> +\begin{lstlisting}
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0) /* \hyperre=
f[intro:gre_rfc2784]{[GRE_rfc2784]} */
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1) /* \hyperre=
f[intro:gre_rfc2890]{[GRE_rfc2890]} */
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2) /* \hyperre=
f[intro:gre_rfc7676]{[GRE_rfc7676]} */
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3) /* \hyperre=
f[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} */
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4) /* \hyperre=
f[intro:vxlan]{[VXLAN]} */
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5) /* \hyperre=
f[intro:vxlan_gpe]{[VXLAN-GPE]} */
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6) /* \hyperre=
f[intro:geneve]{[GENEVE]} */
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7) /* \hyperre=
f[intro:ipip]{[IPIP]} */
>>>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8) /* \hyperre=
f[intro:nvgre]{[NVGRE]} */
>>>>> +\end{lstlisting}
>>>> I'm afraid this one doesn't come out quite as intended, we'll end up
>>>> with verbatim "\hyperref" text instead of a link. Anyone have a good
>>>> idea on how to fix that?
>>>>
>>>> I'd prefer to push this now with the first issue addressed and to do a=
n
>>>> (editorial) patch on top to deal with the second issue (unless someone
>>>> can come up with a really trivial fix for it, then I can apply that
>>>> straightaway.)
>>> Someone suggested using escapechar:
>>> https://tex.stackexchange.com/questions/314903/inline-links-in-code-lis=
tings
>>>
>>> Didn't try.
>> Looks reasonable (and also revealed a typo for VXLAN-GPE). I think I'll
>> go ahead with this one.
>
> Yes. "intro:vxlan_gpe" -> "intro:vxlan-gpe".
>
> May I ask if the fix to these two problems is for me to make fix patches=
=20
> or for you to solve it when editing?

I'd fix it myself while applying, but...

...while the changes above give me a fine pdf, the html generated is
broken. The problem seems to originate in the normative references that
are added in introduction.tex, but I don't see where it goes astray.

[401] [402] [403] [404] (./virtio-v1.2-cs01.aux
! Missing \endcsname inserted.
<to be read again>=20
                   \unhbox=20
l.49 ...ction}Normative References}}{section.1}{}}
                                                 =20
?=20
! Emergency stop.
<to be read again>=20
                   \unhbox=20
l.49 ...ction}Normative References}}{section.1}{}}

(makehtml.sh on master seems to work ok, so it's something in this
patch...)

Does anyone else manage to spot the problem?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

