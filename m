Return-Path: virtio-dev-return-4748-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC47A985CA0
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Jul 2018 11:51:26 +0000 (UTC)
Date: Fri, 27 Jul 2018 14:51:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180727144726-mutt-send-email-mst@kernel.org>
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
 <1514626559-162312-2-git-send-email-longpeng2@huawei.com>
 <fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
 <5B51CF0B.8020706@huawei.com>
 <a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [v23 1/2] virtio-crypto: Add
 virtio crypto device specification
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, liang.j.ma@intel.com, jasowang@redhat.com, xin.zeng@intel.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 26, 2018 at 06:55:44PM +0200, Halil Pasic wrote:
> Sorry I did not have any time for this last days. And this
> to make it worse this is a follow up to something that was
> half a year ago. That means I have to re-familiarize myself
> with the topic.
> 
> If I don't get around to answer in couple of weeks, feel
> free to ping me.
> 
> Since from what I've seen most of the questions were of type
> 'Can we do it like this?', maybe sending out a new version
> is the best. So people (like me) can read through the whole
> thing and point out problems if any.
> 
> Regards,
> Halil


While two weeks for review is borderline reasonable as an exception, it
does trouble me that  we are at v23, for something that is used
in the field so it's not like we can just change things at will.
So I hope everyone concerned makes an effort to try to converge on a spec
ASAP.

> On 07/20/2018 02:01 PM, Longpeng (Mike) wrote:
> > 
> > 
> > On 2018/1/10 1:05, Halil Pasic wrote:
> > 
> > > 
> > > 
> > > On 12/30/2017 10:35 AM, Longpeng(Mike) wrote:
> > > > From: Gonglei <arei.gonglei@huawei.com>
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

