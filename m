Return-Path: <virtio-dev-return-8788-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D9157986495
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Oct 2021 06:45:45 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211005174532-mutt-send-email-mst@kernel.org>
References: <20210930163503.51200-1-jean-philippe@linaro.org>
 <87a6jn1ka9.fsf@redhat.com>
 <20211005174532-mutt-send-email-mst@kernel.org>
Date: Wed, 06 Oct 2021 08:45:12 +0200
Message-ID: <877deq1wjr.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] virtio-iommu: Rework the bypass feature
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, virtio-dev@lists.oasis-open.org, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 05 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Oct 05, 2021 at 06:57:50PM +0200, Cornelia Huck wrote:
>> On Thu, Sep 30 2021, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
>> >  \item[VIRTIO_IOMMU_F_BYPASS (3)]
>> > -  When not attached to a domain, endpoints downstream of the IOMMU
>> > -  can access the guest-physical address space.
>> > +  This feature is deprecated.
>> 
>> "and must not be negotiated." ?
>> 
>> Not sure if we should add normative statements for that.
>
> We can't just make existing art de jure illegal.
>
> So SHOULD NOT and yes needs confirmance statements.
> Given documentation is already there why remove it?

Right, let's make that SHOULD NOT.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

