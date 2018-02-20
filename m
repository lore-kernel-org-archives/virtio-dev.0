Return-Path: virtio-dev-return-3240-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 581B85819220
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2018 03:28:21 -0800 (PST)
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
 <20180214145340.1223-2-jean-philippe.brucker@arm.com>
 <417e1617-e5ff-7b13-64e3-a8a98d30bcb9@semihalf.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <ab5bf4f1-9564-9dc6-fefe-5c96352da1be@arm.com>
Date: Tue, 20 Feb 2018 11:30:41 +0000
MIME-Version: 1.0
In-Reply-To: <417e1617-e5ff-7b13-64e3-a8a98d30bcb9@semihalf.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 1/4] iommu: Add virtio-iommu driver
To: Tomasz Nowicki <tn@semihalf.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19/02/18 12:23, Tomasz Nowicki wrote:
[...]
>> +static int viommu_receive_resp(struct viommu_dev *viommu, int nr_sent,
>> +			       struct list_head *sent)
>> +{
>> +
>> +	unsigned int len;
>> +	int nr_received = 0;
>> +	struct viommu_request *req, *pending;
>> +
>> +	pending = list_first_entry_or_null(sent, struct viommu_request, list);
>> +	if (WARN_ON(!pending))
>> +		return 0;
>> +
>> +	while ((req = virtqueue_get_buf(viommu->vq, &len)) != NULL) {
>> +		if (req != pending) {
>> +			dev_warn(viommu->dev, "discarding stale request\n");
>> +			continue;
>> +		}
>> +
>> +		pending->written = len;
>> +
>> +		if (++nr_received == nr_sent) {
>> +			WARN_ON(!list_is_last(&pending->list, sent));
>> +			break;
>> +		} else if (WARN_ON(list_is_last(&pending->list, sent))) {
>> +			break;
>> +		}
>> +
>> +		pending = list_next_entry(pending, list);
> 
> We should remove current element from the pending list. There is no 
> guarantee we get response for each while loop so when we get back for 
> more the _viommu_send_reqs_sync() caller will pass pointer to the out of 
> date head next time.

Right, I'll fix this

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

