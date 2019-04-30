Return-Path: virtio-comment-return-719-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20190314153253.50945-1-jean-philippe.brucker@arm.com>
 <9ff6957a-b7bc-27e8-a7d1-cf9e3c956aa1@arm.com>
 <80ccc3c1-4e2d-7ee1-97c8-a2e13a90053c@redhat.com>
 <20190430084321-mutt-send-email-mst@kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <3c4f6c52-279c-b7d9-0070-5165a1bfd497@arm.com>
Date: Tue, 30 Apr 2019 14:40:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190430084321-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v2] Add virtio-iommu device specification
To: "Michael S. Tsirkin" <mst@redhat.com>, Auger Eric <eric.auger@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, tnowicki@caviumnetworks.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 30/04/2019 13:45, Michael S. Tsirkin wrote:
> On Thu, Apr 25, 2019 at 01:29:17PM +0200, Auger Eric wrote:
>> Hi,
>> On 4/23/19 1:15 PM, Jean-Philippe Brucker wrote:
>>> Hi,
>>>
>>> On 14/03/2019 15:32, Jean-Philippe Brucker wrote:
>>>> The IOMMU device allows a guest to manage DMA mappings for physical,
>>>> emulated and paravirtualized endpoints. Add device description for the
>>>> virtio-iommu device and driver. Introduce PROBE, ATTACH, DETACH, MAP and
>>>> UNMAP requests, as well as translation error reporting.
>>>>
>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/37
>>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>>
>>> If there aren't any more comments on this version, could I request a
>>> vote? The virtio-iommu spec has been reviewed on the virtio-dev list by
>>> several of the people on Cc. The Linux driver has been in good shape for
>>> a while, but Joerg would like to see progress on this specification
>>> before merging it upstream. It's too late in the release cycle for Linux
>>> v5.2, but I'm hoping to get something in v5.3.
>> Is there any calendar for the "OASIS Virtual I/O Device (VIRTIO) TC" votes?
> 
> I started the vote but had to withdraw the ballot as the issue does not link to
> the latest proposal (is v2 the correct one?). Please edit the issue to
> link to latest proposal and request the vote again.

Ok, although I noticed that this v2 has a conflict with the upstream
conformance.tex. So I'll send a v3 and update the github link once it
appears in the mailinglist archive, then I'll request the vote again

Thanks,
Jean

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

