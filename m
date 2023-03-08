Return-Path: <virtio-dev-return-11527-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109D1C678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:16:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4CF452ACB1
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:16:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 44C719866FD
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:16:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 35A5F9866EE; Wed,  8 Mar 2023 14:16:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2498D9866EF
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 14:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: z_VWU1RYM0WiRa1VG_0svg-1
From: Cornelia Huck <cohuck@redhat.com>
To: David Edmondson <david.edmondson@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
 nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
 virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit
 <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <m2r0u0zxkk.fsf@oracle.com>
Organization: Red Hat GmbH
References: <cover.1677761896.git.mst@redhat.com>
 <0a784140387c2a592f7e1e7bbc5ae926ec5b45da.1677761896.git.mst@redhat.com>
 <m2leka0yvl.fsf@oracle.com>
 <20230306165907-mutt-send-email-mst@kernel.org>
 <m2r0u0zxkk.fsf@oracle.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 08 Mar 2023 15:16:41 +0100
Message-ID: <87fsafl452.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio] [PATCH v10 01/10] virtio: document forward
 compatibility guarantees

On Tue, Mar 07 2023, David Edmondson <david.edmondson@oracle.com> wrote:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> On Mon, Mar 06, 2023 at 01:53:50PM +0000, David Edmondson wrote:
>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>> 
>>> > Feature negotiation forms the basis of forward compatibility
>>> > guarantees of virtio but has never been properly documented.
>>> > Do it now.
>>> >
>>> > Suggested-by: Halil Pasic <pasic@linux.ibm.com>
>>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> > ---
>>> >  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>>> >  1 file changed, 42 insertions(+)
>>> >
>>> > diff --git a/content.tex b/content.tex
>>> > index 0e474dd..0c2d917 100644
>>> > --- a/content.tex
>>> > +++ b/content.tex
>>> > @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>>> >  In particular, new fields in the device configuration space are
>>> >  indicated by offering a new feature bit.
>>> >  
>>> > +To keep the feature negotiation mechanism extensible, it is important
>>> > +that devices \em{do not} offer any feature bits that they would not be
>>> > +able to handle if the driver accepted them (even though drivers are not
>>> > +supposed to accept them in the first place even if offered, according to
>>> > +this version of the specification.) 
>>> 
>>> I find this (the bit in parenthesis) confusing.
>>> 
>>> Why are drivers not supposed to accept features that they have been
>>> offered, given that they can't know that the device cannot handle the
>>> feature that it just offered?
>>> 
>>> Is this alluding to the later section:
>>> 
>>> > feature bits not described in this specification, reserved feature
>>> > bits and feature bits reserved or not supported for the specific
>>> > transport or the specific device type
>>> 
>>> ?
>>
>> exactly. how would you put this better? given an example?
>
> Perhaps it would be enough to say:
>
>> (even though drivers are not supposed to accept unrecognised features in
>> the first place even if offered, according to the specification)
>
> "Unrecognised" is intended as a shorthand for the whole "not described,
> reserved, ...". Maybe "unrecognised or reserved"?

Hm, what about

"even though drivers are not supposed to accept any unspecified,
reserved, or unsupported features even if offered..."

?

I'm not sure how we can make this both short and descriptive enough...


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

