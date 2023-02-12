Return-Path: <virtio-comment-return-4170-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <1c02a2d3-5b7b-3999-0aa9-94246b9b2337@nvidia.com>
Date: Sun, 12 Feb 2023 14:10:29 +0200
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-3-mst@redhat.com> <m2zg9m284x.fsf@oracle.com>
 <20230209100903-mutt-send-email-mst@kernel.org> <m2v8ka273u.fsf@oracle.com>
 <04a5ea57-05a0-8a67-dda1-636658e0bf95@nvidia.com>
 <20230209143919-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230209143919-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v10 02/10] admin: introduce device group
 and related concepts
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Edmondson <david.edmondson@oracle.com>, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 09/02/2023 21:58, Michael S. Tsirkin wrote:
> On Thu, Feb 09, 2023 at 07:47:56PM +0200, Max Gurtovoy wrote:
>>
>> On 09/02/2023 17:22, David Edmondson wrote:
>>
>>      On Thursday, 2023-02-09 at 10:13:46 -05, Michael S. Tsirkin wrote:
>>
>>          On Thu, Feb 09, 2023 at 03:00:58PM +0000, David Edmondson wrote:
>>
>>              On Thursday, 2023-02-09 at 07:13:36 -05, Michael S. Tsirkin wrote:
>>
>>                  Each device group has a type. For now, define one initial group:
>>
>>                  SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
>>                  PCI SR-IOV physical function (PF). This group may contain one or more
>>                  virtio devices.
>>
>>              The specification says zero or more generally and nothing to refine that
>>              for SR-IOV groups.
>>
>>          Well it says:
>>
>>                  (SR-IOV) physical function (PF) device as the owner and includes
>>                  all its SR-IOV virtual functions (VFs) as members (see
>>                  \hyperref[intro:PCIe]{[PCIe]}).
>>
>>          how can that be zero?
>>
>>      If I remove all of the VFs of a PF, does the group implicitly disappear?
>>
>> Enable/Disable SR-IOV are dynamic operations controlled by NumVFs register.
> 
> Are you sure? Not by VF Enable?

Right. It's a combination of the VF_Enable and numVfs.

...
"The NumVFs field defines the number of VFs that are enabled when VF 
Enable is Set in the associated PF."

> 
>> We can mention that a group include all virtual functions indicated by TotalVFs
>> RO register.
> 
> TotalVFs indicates the maximum number of VFs that could be associated with the PF
> but not all of these exist. If we use this we get into issues of
> discovering whether VFs can actually be used. I'd rather avoid that.
> 
> 
>> This group exist as long as the owner PF supports SR-IOV and has admin
>> capabilities.
> 
> SRIOV spec says:
> 	NumVFs controls the number of VFs that are visible.
> 
> And one can not play with NumVFs dynamically:
> 
> 	NumVFs may only be written while VF Enable is Clear. If NumVFs is written when VF Enable is
> 	Set, the results are undefined.
> 
> one has to kill all VFs then enable them all again.
> As long as we are doing that, we can just unload the driver.
what driver to unload ? Not sure I'm following..

> 
> So I would say we should just ask that VF Enable is set
> before poking at admin vq, and prohibit clearing VF Enable.
> 

Sending admin commands shouldn't be restricted and should be allowed 
always. Device should react to incoming command.

We can say that an SR-IOV group is empty while the VF enable is unset 
and is not empty when it's set. The size of the non empty SR-IOV group 
is equal to the numVFs and the VF index is equal to the member 
identifier in this group. I had this definition in my patches.

Sending admin command to a non existing member will result in an ERROR 
VIRTIO_ADMIN_STATUS_Q_INVALID_MEM.

> 
> There's also the concern of VF migration under MRIOV where VFs might
> not exit. I'm guessing
> trying to include that right now is overthinking. So maybe
> this should mention that VF Migration Capable should be clear.
> 
> 
> I will add all this to the spec.
> 
> 
>>      How about the converse?
>>
>>
>>                  Each device within a group has a unique identifier. This identifier
>>                  is the group member identifier.
>>
>>                  Note: one can argue both ways whether the new device group handling
>>                  functionality (this and following patches) is closer
>>                  to a new device type or a new transport type.
>>
>>                  However, I expect that we will add more features in the near future. To
>>                  facilitate this as much as possible of the text is located in the new
>>                  admin chapter.
>>
>>                  I did my best to minimize transport-specific text.
>>
>>                  Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>                  Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>                  ---
>>                   admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>                   content.tex |  2 ++
>>                   2 files changed, 51 insertions(+)
>>                   create mode 100644 admin.tex
>>
>>                  diff --git a/admin.tex b/admin.tex
>>                  new file mode 100644
>>                  index 0000000..2bc7322
>>                  --- /dev/null
>>                  +++ b/admin.tex
>>                  @@ -0,0 +1,49 @@
>>                  +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
>>                  +
>>                  +It is occasionally useful to have a device control a group of
>>                  +other devices. Terminology used in such cases:
>>                  +
>>                  +\begin{description}
>>                  +\item[Device group]
>>                  +        or just group, includes zero or more devices.
>>                  +\item[Owner device]
>>                  +        or owner, the device controlling the group.
>>                  +\item[Member device]
>>                  +        a device within a group. The owner device itself is not
>>                  +       a member of the group.
>>                  +\item[Member identifier]
>>                  +        each member has this identifier, unique within the group
>>                  +       and used to address it through the owner device.
>>                  +\item[Group type identifier]
>>                  +       specifies what kind of member devices there are in a
>>                  +       group, how is the member identifier is interpreted
>>                  +       and what kind of control the owner has.
>>                  +       A given owner can control a single group of a given type,
>>                  +       thus the type and the owner together identify the group.
>>                  +       \footnote{Even though some group types only support
>>                  +                       specific transports, group type identifiers
>>                  +                       are global rather than transport-specific -
>>                  +                       we don't expect a flood of new group types.}
>>                  +\end{description}
>>                  +
>>                  +The following group types, and their identifiers, are currently specified):
>>                  +\begin{description}
>>                  +\item[SR-IOV group type (0x1)]
>>                  +This device group has a PCI Single Root I/O Virtualization
>>                  +(SR-IOV) physical function (PF) device as the owner and includes
>>                  +all its SR-IOV virtual functions (VFs) as members (see
>>                  +\hyperref[intro:PCIe]{[PCIe]}).
>>                  +
>>                  +The PF device itself is not a member of the group.
>>                  +
>>                  +The group type identifier for this group is 0x1.
>>                  +
>>                  +A member identifier for this group can have a value 0x1 to 0xFFFF
>>                  +and equals the SR-IOV VF number of the member device (see
>>                  +\hyperref[intro:PCIe]{[PCIe]}).
>>                  +
>>                  +Both owner and member devices for this group type use the Virtio
>>                  +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
>>                  +\end{description}
>>                  +
>>                  +
>>                  diff --git a/content.tex b/content.tex
>>                  index 0c2d917..ffe45c4 100644
>>                  --- a/content.tex
>>                  +++ b/content.tex
>>                  @@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>>                   types. It is RECOMMENDED that devices generate version 4
>>                   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>
>>                  +\input{admin.tex}
>>                  +
>>                   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>>
>>                   We start with an overview of device initialization, then expand on the
>>
>>              --
>>              Tell her I'll be waiting, in the usual place.
>>
> 

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

