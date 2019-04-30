Return-Path: virtio-comment-return-717-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 30 Apr 2019 08:41:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190430084125-mutt-send-email-mst@kernel.org>
References: <20190314153253.50945-1-jean-philippe.brucker@arm.com>
 <9ff6957a-b7bc-27e8-a7d1-cf9e3c956aa1@arm.com>
 <80ccc3c1-4e2d-7ee1-97c8-a2e13a90053c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ccc3c1-4e2d-7ee1-97c8-a2e13a90053c@redhat.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v2] Add virtio-iommu device specification
To: Auger Eric <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, tnowicki@caviumnetworks.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 25, 2019 at 01:29:17PM +0200, Auger Eric wrote:
> Hi,
> On 4/23/19 1:15 PM, Jean-Philippe Brucker wrote:
> > Hi,
> > 
> > On 14/03/2019 15:32, Jean-Philippe Brucker wrote:
> >> The IOMMU device allows a guest to manage DMA mappings for physical,
> >> emulated and paravirtualized endpoints. Add device description for the
> >> virtio-iommu device and driver. Introduce PROBE, ATTACH, DETACH, MAP and
> >> UNMAP requests, as well as translation error reporting.
> >>
> >> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/37
> >> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > If there aren't any more comments on this version, could I request a
> > vote? The virtio-iommu spec has been reviewed on the virtio-dev list by
> > several of the people on Cc. The Linux driver has been in good shape for
> > a while, but Joerg would like to see progress on this specification
> > before merging it upstream. It's too late in the release cycle for Linux
> > v5.2, but I'm hoping to get something in v5.3.
> Is there any calendar for the "OASIS Virtual I/O Device (VIRTIO) TC" votes?

All active and past ballots are here:
https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio

>  I think the QEMU device
> > will follow the Linux driver since it depends on API headers.
> Yes sure I will respin the QEMU VIRTIO-IOMMU device accordingly.
> 
> Thanks
> 
> Eric
> > 
> > Thanks,
> > Jean
> > 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

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

