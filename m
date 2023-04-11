Return-Path: <virtio-dev-return-12109-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44714C7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:39:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 653A87C260
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:39:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59B1F986549
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:39:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4E23D983DFF; Tue, 11 Apr 2023 08:39:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E74B98636D
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 08:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: HmEVBU-0MpCJ276-nnEJmA-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
 Satananda Burla <sburla@marvell.com>
In-Reply-To: <20230410155819-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
 <87jzysjd4g.fsf@redhat.com>
 <20230404084126-mutt-send-email-mst@kernel.org>
 <878rf7kcna.fsf@redhat.com>
 <20230404102053-mutt-send-email-mst@kernel.org>
 <fce3c697-55a6-1410-2f42-db6499bd8f87@nvidia.com>
 <20230410154518-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548109DAABB563E4DA3040CADC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230410155819-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 11 Apr 2023 10:39:34 +0200
Message-ID: <87leiyke2h.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Mon, Apr 10 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 10, 2023 at 07:57:08PM +0000, Parav Pandit wrote:
>> 
>> > From: Michael S. Tsirkin <mst@redhat.com>
>> > Sent: Monday, April 10, 2023 3:49 PM
>> 
>> > Attribution is nice but Signed-off-by is not that.
>> 
>> Then what is Signed-off-by for virtio spec?
>
> we never defined it. using it kind of by 
>
>> Can it be same definition as what Linux kernel and many other projects use like [1]?
>> 
>> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=signed%20off
>
> That is DCO. useful for linux pointless for us as is since
> we want people to agree to our IPR.
> Unless you want to make DCO refer to our IPR.
> That might be possible.
> We will need to float this past OASIS stuff.
> I prefer explicit agreement to license personally.

In most projects, s-o-b either means "I abide by the DCO", or "I'm
adding this because it seems to be the usual thing to do". "Agreeing to
the IPR" would be a somewhat surprising meaning, so I'd prefer to keep
IPR agreement separate as well. Not sure if we want to actually
specify what we mean by s-o-b; when I'm attaching it when merging I'm
using it mostly in the "let's record the chain" meaning. (Specifying
that we indeed use it in that sense, and not the full DCO sense, might
make sense -- or it might be overkill.)

>
>> > And fundamentally people go read the PDF where the Signed-off-by does not
>> > appear at all no one pokes at git history.
>> When people read PDF, they do not care about the sign-off. Signed-off-by is not for that.
>> 
>> > Let's just do:
>> > 
>> > Thanks-to: name <email>
>> > 
>> Why to now learn a new term?
>> Why terminology of [1] is not enough like AQ status codes? :)
>
> I have no idea what problem you are trying to address.
> If it is attribution Signed-off-by is not that.
> If it is IPR Signed-off-by is not that either but might be
> made to imply that.

Yes, s-o-b is distinct from attribution (and that's why the Linux kernel
requires it on top of a Co-developed-by: to satisfy the DCO, not instead
of it.) If we think that Co-developed-by: without a s-o-b might be
confusing, a Thanks-to: could be a better term (and also a broader one
meaning "I discussed this with this person, and I want to acknowledge
them".)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

