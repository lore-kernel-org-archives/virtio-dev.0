Return-Path: <virtio-dev-return-14218-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19756C47077
	for <virtio-dev@archiver.kernel.org>; Thu, 11 Jan 2024 16:27:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6CE0F1922E1
	for <virtio-dev@archiver.kernel.org>; Thu, 11 Jan 2024 16:27:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6813B9866C8
	for <virtio-dev@archiver.kernel.org>; Thu, 11 Jan 2024 16:27:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A3569866A3; Thu, 11 Jan 2024 16:27:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47E219866AB
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Jan 2024 16:27:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lK7udtMhOUaZA9OPJ6vjzA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>, "virtio@lists.oasis-open.org"
 <virtio@lists.oasis-open.org>
In-Reply-To: <79c04138-6e41-4b53-a830-33bfa36501bb@linux.alibaba.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <1704263702-50528-1-git-send-email-hengqi@linux.alibaba.com>
 <9f223f31-d82d-4554-817b-d46327a9cdee@linux.alibaba.com>
 <79c04138-6e41-4b53-a830-33bfa36501bb@linux.alibaba.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 11 Jan 2024 17:27:24 +0100
Message-ID: <87mstbomxf.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH v8] virtio-net: correct conditions for
 devices to validate packet checksum

On Thu, Jan 11 2024, Heng Qi <hengqi@linux.alibaba.com> wrote:

> =E5=9C=A8 2024/1/4 =E4=B8=8B=E5=8D=8812:47, Heng Qi =E5=86=99=E9=81=93:
>>
>>
>> =E5=9C=A8 2024/1/3 =E4=B8=8B=E5=8D=882:35, Heng Qi =E5=86=99=E9=81=93:
>>> There is a historical error in virtio spec:
>>> =C2=A0=C2=A0 "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device =
*MUST*=20
>>> set flags
>>> =C2=A0=C2=A0=C2=A0 to zero and SHOULD supply a fully checksummed packet=
 to the driver."
>>>
>>> Currently in Linux and virtio-related implementations, the device=20
>>> validates
>>> the packet checksum and sets DATA_VALID regardless of whether
>>> VIRTIO_NET_F_GUEST_CSUM is negotiated.
>>>
>>> Please refer to the following summary and thread[1] for details and=20
>>> reasons:
>>>
>>> Summary
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> 1. GUEST_CSUM at virtio spec 0.95 is intended to be compatible with=20
>>> partially
>>> checksummed packets (NEEDS_CSUM <-> CHECKSUM_PARTIAL). So GUEST_CSUM=20
>>> is mapped
>>> to NETIF_F_RXCSUM.
>>> GUEST_CSUM only indicates whether the driver handles partially=20
>>> checksummed packets.
>>> When XDP is loaded, the GUEST_CSUM's offload will be disabled, which=20
>>> means that
>>> packets have NEEDS_CSUM set will be dropped, and packets have=20
>>> DATA_VALID set will
>>> still be received.
>>>
>>> 2. When DATA_VALID was added to Linux in 2011[2] and virtio1.0, it=20
>>> was actually
>>> expected that rx checksum offload (the driver can set=20
>>> CHECKSUM_UNNECESSARY) had
>>> nothing to do with whether GUEST_CSUM was negotiated. But due to an=20
>>> error, below
>>> desctiption was added incorrectly:
>>> =C2=A0=C2=A0 "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device =
*MUST*=20
>>> set flags
>>> =C2=A0=C2=A0=C2=A0 to zero and SHOULD supply a fully checksummed packet=
 to the driver."
>>>
>>> 3. We now hope to correct this error. Let the setting of DATA_VALID=20
>>> not be
>>> controlled by whether GUEST_CSUM is negotiated, but only controlled=20
>>> by whether
>>> rx checksum offload is enabled on the OS side. The state of this rx=20
>>> checksum
>>> offload is not aware of the device.
>>>
>>> 4. [Optional] NETIF_F_RXCSUM corresponding to rx checksum offload=20
>>> should be
>>> added to dev->hw_features. When the user turns off rx checksum=20
>>> offload through
>>> ethtool -K, neither NEEDS_CSUM nor DATA_VALID should be taken care=20
>>> of, that is,
>>> all packets will be marked as CHECKSUM_NONE.
>>>
>>> Related Link
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [1]=20
>>> https://lists.oasis-open.org/archives/virtio-comment/202312/msg00135.ht=
ml
>>> [2] 10a8d94a9574 ("virtio_net: introduce VIRTIO_NET_HDR_F_DATA_VALID")
>>>
>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/185
>>
>> Hi Michael, Cornelia.
>>
>> Could you please open a voting for this fix?
>
> Hi Michael and Cornelia.
>
> Sincerely asking if you missed this message?

I've been back from end-of-year PTO only this week...

I'm currently waiting for a confirmed updated schedule for the
infrastructure migration, as I don't want to risk having the platform
out of order in the middle of the voting period.

>
> In addition, Jason recently responded with his reviewed-by tag.
> Do I need to publish a new version carrying his tag (thanks Jason)?

No, we can add his R-b when pushing to git.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

