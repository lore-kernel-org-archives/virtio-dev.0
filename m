Return-Path: virtio-dev-return-2642-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B8F5958180CE
	for <virtio-dev@lists.oasis-open.org>; Tue, 31 Oct 2017 10:55:56 -0700 (PDT)
Date: Tue, 31 Oct 2017 19:55:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171031193818-mutt-send-email-mst@kernel.org>
References: <ad5f63b4-e576-3778-9080-4c4e3e5710cb@arm.com>
 <20171030183541-mutt-send-email-mst@kernel.org>
 <fc043b26-32f5-bcce-78dd-b38e829eb3f9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc043b26-32f5-bcce-78dd-b38e829eb3f9@arm.com>
Subject: [virtio-dev] Re: Status of virtio-iommu
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 30, 2017 at 06:31:50PM +0000, Jean-Philippe Brucker wrote:
> On 30/10/17 16:40, Michael S. Tsirkin wrote:
> > Adding an issue saves me work, if you can do it and list issue
> > number in the commit log, that's great.
> 
> Are you still using the JIRA from OASIS, or github instead? It seems like
> non-TC-members can't create issues on the OASIS one.
> 
> Thanks,
> Jean

My ballot scripts still only work with OASIS one.  I just pushed them to
virtio-admin if you want to play with github APIs, specifically
ballot-issue.sh which calls virtio-jira.pl and virtio-tc.pl

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

