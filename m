Return-Path: <virtio-dev-return-12199-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BE3C7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 16:16:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 906E429FC8
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 16:16:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 800879865FD
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 16:16:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74DFD9865D6; Wed, 12 Apr 2023 16:16:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 626359865F0
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 16:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rKfRi9BdPkuS0M5_sNKD9A-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
In-Reply-To: <20230407071926-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <87edoyqvnu.fsf@redhat.com>
 <20230407071926-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 12 Apr 2023 18:16:41 +0200
Message-ID: <87r0spjct2.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [RFC] virtio 1.3 schedule

On Fri, Apr 07 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 05, 2023 at 03:57:09PM +0200, Cornelia Huck wrote:
>> That said, let me propose the following timeline:
>> 
>> - July 1st 2023: enter feature freeze; all proposed changes must at
>>   least have an open github issue that refers to a proposal on-list
>> - August 1st 2023: enter change freeze; everything needs to have been
>>   voted upon (i.e. we can start with preparations for a release like
>>   compiling the change log)
>> - at the same time, fork virtio-next, which can be used for development
>>   while we're working on the release
>> - August/September 2023: prepare draft, initiate initial voting etc.
>
> Hmm looks like you forgot a 30 day the public review period (or is that
> included in the "etc"? ).  During this period we will likely receive
> review comments which we have to address. Should the changes turn out to
> be material, another public review period will be required.
> Let's spell it out please.

Yeah, that's what I meant with "etc"... let's make this:

- August 2023: prepare draft, aim to have it ready and voted upon by
  August 31 the latest (preferrably earlier)
- September 2023: public review period (30 days)
- October 2023: another public review period, if needed; otherwise, get
  comittee specification ready and voted upon
- October (maybe November, if we're running late) 2023: virtio 1.3
  released

The most important dates are feature freeze on Jul 1 and change freeze
on Aug 1, I guess; for the rest, we depend on whether people are out on
PTO, which kind of feedback we get, etc. -- but as long as we release
1.3 in 2023, I'll be happy enough.

>
>
>
>> - by September/October 2023: have the final 1.3 spec ready, voted upon,
>>   and released
>> - virtio-next can be merged into mainline, and we continue with business
>>   as usual
>> 
>> Thoughts? We might want to move things a tad earlier, but I don't think
>> we should push the schedule out much further.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

