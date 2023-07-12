Return-Path: <virtio-dev-return-13355-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D671BEB64D9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 15:24:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 03AED190908
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 15:24:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC0B99867AF
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 15:24:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C4970986682; Wed, 12 Jul 2023 15:24:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B243D986686
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2023 15:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: LOLH3hanOtyFunjcXmL9HQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
In-Reply-To: <b1b03bfa-45ac-42b8-86d9-aaf47c4704e3@linux.alibaba.com>
Organization: Red Hat GmbH
References: <20230703152711.106008-1-hengqi@linux.alibaba.com>
 <87pm4xjp4t.fsf@redhat.com>
 <20230712082508-mutt-send-email-mst@kernel.org>
 <87jzv5jo82.fsf@redhat.com>
 <e0e2b21d-a7f9-fbf1-7d93-d142c7a7618a@linux.alibaba.com>
 <87h6q9jm85.fsf@redhat.com>
 <b1b03bfa-45ac-42b8-86d9-aaf47c4704e3@linux.alibaba.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 12 Jul 2023 17:23:13 +0200
Message-ID: <87edldjgri.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v21] virtio-net: support inner header hash

On Wed, Jul 12 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:

> =E5=9C=A8 2023/7/12 =E4=B8=8B=E5=8D=889:25, Cornelia Huck =E5=86=99=E9=81=
=93:
>> ...while the changes above give me a fine pdf, the html generated is
>> broken. The problem seems to originate in the normative references that
>> are added in introduction.tex, but I don't see where it goes astray.
>>
>> [401] [402] [403] [404] (./virtio-v1.2-cs01.aux
>> ! Missing \endcsname inserted.
>> <to be read again>
>>                     \unhbox
>> l.49 ...ction}Normative References}}{section.1}{}}
>>                                                   =20
>> ?
>> ! Emergency stop.
>> <to be read again>
>>                     \unhbox
>> l.49 ...ction}Normative References}}{section.1}{}}
>>
>> (makehtml.sh on master seems to work ok, so it's something in this
>> patch...)
>>
>> Does anyone else manage to spot the problem?
>
> The problem is that underline cannot be added directly in \textbf, we=20
> need a little modification:
>
> \textbf{[GRE_rfc2784]} --> \textbf{[GRE\_rfc2784]}
> \textbf{[GRE_rfc2890]} --> \textbf{[GRE\_rfc2890]}
> \textbf{[GRE_rfc7676]} --> \textbf{[GRE\_rfc7676]}
>
> After this modification, I can successfully compile pdf on overleaf,=20
> please try this.

I'm afraid that's not the problem (I had tried this and similar changes
without success); the pdf generation is already fine, but html still
fails with this change (or similar).

[Trying on a standard Fedora 37 with a full texlive install...]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

