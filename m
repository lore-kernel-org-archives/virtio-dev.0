Return-Path: <virtio-comment-return-2779-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Wed, 2 Mar 2022 18:02:36 +0200
Message-ID: <20220302160237.26742-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v4 0/1] VIRTIO: Introduce MGMT device and Provision maximum MSI-X vectors for a VF
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

In a PCI SR-IOV configuration, MSI-X vectors of the device is precious
device resource. Hence making efficient use of it based on the use case
that aligns to the VM configuration is desired for best system
performance.

For example, today's static assignment of the amount of MSI-X vectors
doesn't allow sophisticated utilization of resources.

A typical cloud provider SR-IOV use case is to create many VFs for
use by guest VMs. Each VM might have a different purpose and different
amount of resources accordingly (e.g. number of CPUs). A common driver
usage of device's MSI-X vectors is proportional to the number of CPUs in
the VM. Since the system administrator might know the amount of CPUs in
the requested VM, he can also configure the VF's MSI-X vectors amount
proportional to the number of CPUs in the VM. In this way, the
utilization of the physical hardware will be improved.

Today we have some operating systems that support provisioning MSI-X
vectors for PCI VFs.

Update the specification to have a method to change the number of MSI-X
vectors supported by a VF using the PF admin virtqueue interface. For that,
we have created a generic admin infrastructure. In this series we extended
it to manage PCI resources of the managed VF by its parent PF.

For that, introduce a new definition of a Management device and a Manged device.
In the future more resources would be provisioned using this mechanism.

The admin virtqueue interface and the virtio subsystem were introduced in
"Introduce virtio subsystem and Admin virtqueue" series in [1].
This series extend the admin command set for management capabilities.

Open issues:
1.  Should we have command to reset all VFs vectors to zero before enabling SR-IOV? Yes/No.
    If yes, is this optimization command must in current series? Or it can be added later?

[1] https://lists.oasis-open.org/archives/virtio-comment/202203/msg00005.html

---

changes from V3:

 - split the seties to 2 parts (virtio subsystem and admin + MSIX configuration and management device)

changes from V2:

1. Addressed below comments from Jason:
 - split admin virtqueue section from admin command set section
 - added device management section in "Basic Facilities of a Virtio Device"
 - mention that management interface may be admin virtqueue (but not a must)
 - add MSI-X configuration sequence

2. Addressed below comments from MST:
 - added conformance sections
 - use decimal instead of hex for bit numbering
 - remove the OOO definitions for AQ
 - explain more about default configuration of MSI-X for VFs

3. Addressed below comments from Cornelia:
 - reword AQ index definitions
 - introduce misc config for PCI transport

4. added vfs_assigned_msix_count attr to VIRTIO_ADMIN_PCI_SRIOV_ATTRS cmd

5. removed the net/blk AQ index definitions (not needed in the new model)

6. rebased on top of master branch commit 88895f56e642aca ("Reserve more feature bits for device type usage")

changes from V1:

1. Addressed below comments from MST:
 - updated cover letter for admin queue motivation
 - removed VIRTIO_F_ADMIN_PCI_VIRT_MANAGER
 - simplified admin queue interface by removing 
   VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER feature bits
 - added a subsection for VF MSI-X control capability in PCI section
 - re-designed interrupt vector management admin commands
 - added a mandatory admin command to expose admin capabilities
 - improved commit messages
 - described error code for unsupported command
 - described error code for errors on invalid VF
 - described system software requirements for supporting MSI-X configuration

2. Addressed comments from Parav
 - extended command opcode to 16-bit
 - improve commit messages

3. Added more command specific error codes

Max Gurtovoy (1):
  Introduce MGMT Admin commands

 admin.tex        | 205 +++++++++++++++++++++++++++++++++++++++++++++--
 content.tex      |  88 ++++++++++++++++++++
 introduction.tex |  25 ++++++
 3 files changed, 310 insertions(+), 8 deletions(-)

-- 
2.21.0


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

