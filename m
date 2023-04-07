Return-Path: <virtio-dev-return-12055-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006BEC6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 09:35:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4860133593
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 09:35:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38ED99865E9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 09:35:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2FB1A9865DA; Fri,  7 Apr 2023 09:35:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E1009865D7
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 09:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rwApV4b9PcWE6czJKt_H5w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680860116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUN1QxS8tngtPGiwDND0RNmvzXdFQesGZi6MV+0SUao=;
        b=4Sa0Dc2C0lwVnqdhDofD0jpalCwBmdc1mwyWs6h+msLywqbeyEG4vfmFZFdpKHU3Sw
         WW83/tzAFsSVuGPDNy+DsldZLeuhvlmwlXGPBF/KzYCen7H/F6mFTkRHqFoJzMnyqwFf
         Vuk7+RUt0K8Ou8DD4mM95Fd+MUn7Tnxw6CNICE+7hBKg3lzVgqZvfkg8iapLrhfRhXzb
         4gmWx7rgqKROsiaYleJzAFC8ObPUYoeSRX+P06ONzYQPbGTyzoWFS7L9v9PMRumfQQ4g
         JZbQpvyTXHiNZI629ETCIMubhsmI1cZXmyXwNAB1v9Q4sVGxEN83/mXFM2j2fw6qc6px
         Eo6Q==
X-Gm-Message-State: AAQBX9cYOstd/1g3bvXzrOWr9dkoUe4+TnqHUL6sXUMrSccECIHy68bC
	PgmaCgD1+xxsZZnrYAxyMCNCndy0og2J/Jmd9qEaByB/I2pddIeVLKi79Cbe0qAZA3p4CPy7/cc
	1VxHRyDUM+OD4Uyl8joDM3UMBJ/25
X-Received: by 2002:adf:e2c4:0:b0:2e4:cc81:8a80 with SMTP id d4-20020adfe2c4000000b002e4cc818a80mr1325898wrj.26.1680860115871;
        Fri, 07 Apr 2023 02:35:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350aD09p0fL8K8Ou+8awVWNiv+AkNFRFsDFAxCueSyZd7a8mgSSiGgeKcvj20FMXvTlcq3j66bg==
X-Received: by 2002:adf:e2c4:0:b0:2e4:cc81:8a80 with SMTP id d4-20020adfe2c4000000b002e4cc818a80mr1325882wrj.26.1680860115514;
        Fri, 07 Apr 2023 02:35:15 -0700 (PDT)
Date: Fri, 7 Apr 2023 05:35:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230407051748-mutt-send-email-mst@kernel.org>
References: <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403130950-mutt-send-email-mst@kernel.org>
 <24e5437e-d6bd-d65c-9ec2-699277a113a3@nvidia.com>
 <20230403135446-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815AFE1FE7E1D2AAABBAF4DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403163730-mutt-send-email-mst@kernel.org>
 <25d15176-042a-f579-0b59-d08f7eb7eafb@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <25d15176-042a-f579-0b59-d08f7eb7eafb@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device

On Mon, Apr 03, 2023 at 06:00:13PM -0400, Parav Pandit wrote:
> 
> 
> On 4/3/2023 5:04 PM, Michael S. Tsirkin wrote:
> > On Mon, Apr 03, 2023 at 08:25:02PM +0000, Parav Pandit wrote:
> > > 
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, April 3, 2023 2:02 PM
> > > 
> > > > > Because vqs involve DMA operations.
> > > > > It is left to the device implementation to do it, but a generic wisdom
> > > > > is not implement such slow work in the data path engines.
> > > > > So such register access vqs can/may be through firmware.
> > > > > Hence it can involve a lot higher latency.
> > > > 
> > > > Then that wisdom is wrong? tens of microseconds is not workable even for
> > > > ethtool operations, you are killing boot time.
> > > > 
> > > Huh.
> > > What ethtool latencies have you experienced? Number?
> > 
> > I know an order of tens of eth calls happens during boot.
> > If as you said each takes tens of ms then we are talking close to a second.
> > That is measureable.
> I said it can take, doesn't have to be always same for all the commands.
> Better to work with real numbers. :)
> 
> Let me take an example to walk through.
> 
> If a cvq or aq command takes 0.5msec, total of 100 such commands will take
> 50msec.
> 
> Once a while if two of commands say take 5msec, will result in 50 -> 60
> msec.

Not too bad. then it seems it should not be a problem to tunnel config
over AQ then?


> 
> > OK then. Then if it is a dead end then it looks weird to add a whole new
> > config space as memory mapped.
> > 
> I am aligned with you to not add any new register as memory mapped for 1.x.
> Or access through device own's tvq is fine if such q can be initialized
> before during device reset (init) phase.
> 
> I explained that legacy registers are sub-set of existing 1.x.
> They should not consume extra memory.
> 
> Lets walk through the merits and negatives of both to conclude.
> 
> > > > Let me try again.
> 
> > If hardware vendors do not want to bear the costs of registers then they
> > will not implement devices with registers, and then the whole thing will
> > become yet another legacy thing we need to support. If legacy emulation
> > without IO is useful, then can we not find a way to do it that will
> > survive the test of time?
> legacy_register_transport_vq for VF can be a option, but not for PF
> emulation.

OK. Do we really care? Are you guys selling lots of high end cards
without SRIOV that it matters?

> More below.
> 
> > 
> > > Again, I want to emphasize that register read/write over tvq has merits with trade-off.
> > > And so the mmr has merits with trade-off too.
> > > 
> > > Better to list them and proceed forward.
> > > 
> > > Method-1: VF's register read/write via PF based transport VQ
> > > Pros:
> > > a. Light weight registers implementation in device for new memory region window
> > 
> > Is that all? I mentioned more.
> > 
> b. device reset is more optimal with transport VQ
> c. a hypervisor may want to check (but not necessary) register content
> d. Some unknown guest VM driver which modifies mac address and still expect
> atomicity can benefit if hypervisor wants to do extra checks

It's not hard to be more specific.
Old Linux kernels are like this, this was fixed with:

commit 7e58d5aea8abb993983a3f3088fd4a3f06180a1c
Author: Amos Kong <akong@redhat.com>
Date:   Mon Jan 21 01:17:23 2013 +0000

Currently we write MAC address to pci config space byte by byte,
this means that we have an intermediate step where mac is wrong.
This patch introduced a new control command to set MAC address,
it's atomic.

about 10 years ago.


> > > Cons:
> > > a. Higher DMA read/write latency
> > > b. Device requires synchronization between non legacy memory mapped registers and legacy regs access via tvq
> > 
> > Same as a separate mmemory bar really.  Just don't do it. Either access
> > legacy or non legacy.
> > 
> It is really not same to treat them equally as tvq encapsulation is
> different, and hw wouldn't prefer to treat them equally like regular memory
> writes.


I think yoiu missunderstand what I said. You listed a problem:
the same device can be accessed through both
a modern and a legacy interface.
I said that it is not a problem at all, there is no reason
to use both.

> Transitional device exposed by hypervisor contains both legacy I/O bar and
> also the memory mapped registers. So a guest vm can access both.

But it must not, and some devices break if you do.


> > > c. Can only work with the VF. Cannot work for thin hypervisor, which can map transitional PF to bare metal OS
> > > (also listed in cover letter)
> > 
> > Is that a significant limitation? Why?
> It is a functional limitation for the PF, as PF has no parent.
> and PF can also utilize memory BAR.

Yes it's a limitation, I just don't see why we care.

> > 
> > > Method-2: VF's register read/write via MMR (current proposal)
> > > Pros:
> > > a. Device utilizes the same legacy and non-legacy registers.
> > 
> > > b. an order of magnitude lower latency due to avoidance of DMA on register accesses
> > > (Important but not critical)
> > 
> > And no cons? Even if you could not see them yourself did I fail to express myself to such
> > an extent?
> > 
> Method-1 pros covered the advantage of it over method-2, but yes worth to
> list here for completeness.
> 
> Cons:
> requires creating new memory region window in the device for configuration
> access

Parav please take a look at the discussion so far as collect more cons
that were mentioned for the proposal, I definitely listed some and I
don't really want to repeat myself.  I expect a proposal to be balanced,
not a sales pitch.


> > > > > No. Interrupt latency is in usec range.
> > > > > The major latency contributors in msec range can arise from the device side.
> > > > 
> > > > So you are saying there are devices out there already with this MMR hack
> > > > baked in, and in hardware not firmware, so it works reasonably?
> > > It is better to not assert a solution a "hack",
> > 
> > Sorry if that sounded offensive.  a hack is not necessary a bad thing.
> > It's a quick solution to a very local problem, though.
> > 
> It is a solution because device can do at near to zero extra memory for
> existing registers.
> Anyways, we have better technical details to resolve. :)
> Lets focus on it.
> 
> > Yes motivation is one of the things I'm trying to work out here.
> > It does however not help that it's an 11 patch strong patchset
> > adding 500 lines of text for what is supposedly a small change.
> > 
> Many of the patches are rework and incorrect to attribute to the specific
> feature.
> 
> Like others it could have been one giant patch... but we see value in
> smaller patches..
> 
> Using tvq is even bigger change than this.

The main thing is that there's no new ID so the PF device itself will
stay usable with existing drivers.

> So we shouldn't be afraid of
> making transitional device actually work using it with larger spec patch.
> 
> > > Regarding tvq, I have some idea on how to improve the register read/writes so that its optimal for devices to implement.
> > 
> > Sounds useful, and maybe if tvq addresses legacy need then focus on
> > that?
> > 
> 
> tvq specific for legacy register access make sense.
> Some generic tvq is abstract and dont see any relation here.
> 
> So better to name it as legacy_reg_transport_vq (lrt_vq).

Again this assumes tvq will be rewritten on top of AQ.
I guess legacy can then become a new type of AQ command?

And maybe you want a memory mapped register for AQ commands? I know
Jason really wanted that.



> How about having below format?
> 
> /* Format of 16B descriptors for lrt_vq
>  * lrt_vq = legacy register tranport vq.
>  */
> struct legacy_reg_req_vf {
> 	union {
> 		struct {
> 			le32 reg_wr_data;
> 			le32 reserved;
> 		} write;
> 		struct {
> 			le64 reg_read_addr;
> 		};
> 	};
> 	le8 rd_wr : 1;	/* rd=0, wr=1 */
> 	le8 reg_byte_offset : 7;
> 	le8 req_tag;	/* unique request tag on this vq */
> 	le16 vf_num;
> 
> 	le16 flags; /* new flag below */
>         le16 next;
> };
> 
> #define VIRTQ_DESC_F_Q_DEFINED 8
> /* Content of the VQ descriptor other than flags field is VQ
>  * specific and defined by the VQ type.
>  */

Any way to allow accesses of arbitrary length?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

