Return-Path: virtio-comment-return-715-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20190314153253.50945-1-jean-philippe.brucker@arm.com>
Message-ID: <9ff6957a-b7bc-27e8-a7d1-cf9e3c956aa1@arm.com>
Date: Tue, 23 Apr 2019 12:15:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190314153253.50945-1-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v2] Add virtio-iommu device specification
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: joro@8bytes.org, tnowicki@caviumnetworks.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On 14/03/2019 15:32, Jean-Philippe Brucker wrote:
> The IOMMU device allows a guest to manage DMA mappings for physical,
> emulated and paravirtualized endpoints. Add device description for the
> virtio-iommu device and driver. Introduce PROBE, ATTACH, DETACH, MAP and
> UNMAP requests, as well as translation error reporting.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/37
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

If there aren't any more comments on this version, could I request a
vote? The virtio-iommu spec has been reviewed on the virtio-dev list by
several of the people on Cc. The Linux driver has been in good shape for
a while, but Joerg would like to see progress on this specification
before merging it upstream. It's too late in the release cycle for Linux
v5.2, but I'm hoping to get something in v5.3. I think the QEMU device
will follow the Linux driver since it depends on API headers.

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

