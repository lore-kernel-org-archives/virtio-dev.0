Return-Path: virtio-comment-return-724-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20190430135648.38369-1-jean-philippe.brucker@arm.com>
 <403f5662-0c6f-efe7-e2e1-c9cf48a19301@arm.com>
 <20190503154502-mutt-send-email-mst@kernel.org>
Message-ID: <bebad5fd-2a44-04c6-53d9-33e95de10dc9@arm.com>
Date: Sun, 5 May 2019 14:33:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190503154502-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v3] Add virtio-iommu device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "joro@8bytes.org" <joro@8bytes.org>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "bauerman@linux.ibm.com" <bauerman@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 03/05/2019 20:47, Michael S. Tsirkin wrote:
> On Tue, Apr 30, 2019 at 03:42:14PM +0100, Jean-Philippe Brucker wrote:
>> On 30/04/2019 14:56, Jean-Philippe Brucker wrote:
>> > The IOMMU device allows a guest to manage DMA mappings for physical,
>> > emulated and paravirtualized endpoints. Add device description for the
>> > virtio-iommu device and driver. Introduce PROBE, ATTACH, DETACH, MAP a=
nd
>> > UNMAP requests, as well as translation error reporting.
>> >=20
>> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/37
>> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>=20
>> I'd like to request a vote for this version (the github issue is now up
>> to date and the patch applies cleanly)
>>=20
>> Thanks,
>> Jean
>=20
> I sent some comments that might be worth addressing before the vote.=A0 If
> you don't agree I'm fine with starting voting now if you like and we'll
> let the TC decide, pls let me know.

Thanks for the review, I agree with most comments. I'll reply this week
and then send a new version, so you can hold off the vote

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

