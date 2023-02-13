Return-Path: <virtio-dev-return-10951-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Message-ID: <aecbd739-3943-9017-5e9d-12b92b192db9@intel.com>
Date: Mon, 13 Feb 2023 17:20:55 +0800
MIME-Version: 1.0
References: <m2zg9m284x.fsf@oracle.com>
 <20230209100903-mutt-send-email-mst@kernel.org> <m2v8ka273u.fsf@oracle.com>
 <04a5ea57-05a0-8a67-dda1-636658e0bf95@nvidia.com>
 <20230209143919-mutt-send-email-mst@kernel.org>
 <1c02a2d3-5b7b-3999-0aa9-94246b9b2337@nvidia.com>
 <20230212075756-mutt-send-email-mst@kernel.org>
 <59414b14-ce94-d083-59b9-5426a687c7e7@nvidia.com>
 <20230212151214-mutt-send-email-mst@kernel.org>
 <fd506a22-36b8-e0fd-d3b6-574b67f551b6@nvidia.com>
 <20230213030709-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230213030709-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v10 02/10] admin:
 introduce device group and related concepts
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 2/13/2023 4:12 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 13, 2023 at 12:49:44AM +0200, Max Gurtovoy wrote:
>>
>> On 12/02/2023 22:19, Michael S. Tsirkin wrote:
>>> On Sun, Feb 12, 2023 at 04:34:09PM +0200, Max Gurtovoy wrote:
>>>>
>>>> On 12/02/2023 15:15, Michael S. Tsirkin wrote:
>>>>> On Sun, Feb 12, 2023 at 02:10:29PM +0200, Max Gurtovoy wrote:
>>>>>>
>>>>>> On 09/02/2023 21:58, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Feb 09, 2023 at 07:47:56PM +0200, Max Gurtovoy wrote:
>>>>>>>> On 09/02/2023 17:22, David Edmondson wrote:
>>>>>>>>
>>>>>>>>         On Thursday, 2023-02-09 at 10:13:46 -05, Michael S. Tsirkin wrote:
>>>>>>>>
>>>>>>>>             On Thu, Feb 09, 2023 at 03:00:58PM +0000, David Edmondson wrote:
>>>>>>>>
>>>>>>>>                 On Thursday, 2023-02-09 at 07:13:36 -05, Michael S. Tsirkin wrote:
>>>>>>>>
>>>>>>>>                     Each device group has a type. For now, define one initial group:
>>>>>>>>
>>>>>>>>                     SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
>>>>>>>>                     PCI SR-IOV physical function (PF). This group may contain one or more
>>>>>>>>                     virtio devices.
>>>>>>>>
>>>>>>>>                 The specification says zero or more generally and nothing to refine that
>>>>>>>>                 for SR-IOV groups.
>>>>>>>>
>>>>>>>>             Well it says:
>>>>>>>>
>>>>>>>>                     (SR-IOV) physical function (PF) device as the owner and includes
>>>>>>>>                     all its SR-IOV virtual functions (VFs) as members (see
>>>>>>>>                     \hyperref[intro:PCIe]{[PCIe]}).
>>>>>>>>
>>>>>>>>             how can that be zero?
>>>>>>>>
>>>>>>>>         If I remove all of the VFs of a PF, does the group implicitly disappear?
>>>>>>>>
>>>>>>>> Enable/Disable SR-IOV are dynamic operations controlled by NumVFs register.
>>>>>>> Are you sure? Not by VF Enable?
>>>>>> Right. It's a combination of the VF_Enable and numVfs.
>>>>>>
>>>>>> ...
>>>>>> "The NumVFs field defines the number of VFs that are enabled when VF Enable
>>>>>> is Set in the associated PF."
>>>>>>
>>>>>>>> We can mention that a group include all virtual functions indicated by TotalVFs
>>>>>>>> RO register.
>>>>>>> TotalVFs indicates the maximum number of VFs that could be associated with the PF
>>>>>>> but not all of these exist. If we use this we get into issues of
>>>>>>> discovering whether VFs can actually be used. I'd rather avoid that.
>>>>>>>
>>>>>>>
>>>>>>>> This group exist as long as the owner PF supports SR-IOV and has admin
>>>>>>>> capabilities.
>>>>>>> SRIOV spec says:
>>>>>>> 	NumVFs controls the number of VFs that are visible.
>>>>>>>
>>>>>>> And one can not play with NumVFs dynamically:
>>>>>>>
>>>>>>> 	NumVFs may only be written while VF Enable is Clear. If NumVFs is written when VF Enable is
>>>>>>> 	Set, the results are undefined.
>>>>>>>
>>>>>>> one has to kill all VFs then enable them all again.
>>>>>>> As long as we are doing that, we can just unload the driver.
>>>>>> what driver to unload ? Not sure I'm following..
>>>>> Basically I am saying that if VFs are disabled this destroys all VFs
>>>>> so it is not
>>>>> clear that it makes sense to keep some of the configuration
>>>>> for previous VFs around.
>>>>>
>>>>> My idea is to say that reset is required to disable VFs.
>>>> which reset ?
>>>>
>>>> VFs disabled/enabled using VF_enable PCI register.
>>>> Lets follow that please.
>>>>
>>>> Lets define what is happening during VF_enable = 1 and VF_enable = 0.
>>>>
>>>> On VF_enable = 0 --> 1 transition the corresponding device_group, that is
>>>> owned by the PF, grows and contains NumVFs members with initial features and
>>>> resources.
>>>>
>>>> On VF_enable = 1 --> 0 transition the corresponding device_group, that is
>>>> owned by the PF, shrinks and contains 0 members and all the dynamic
>>>> resources are back to the owner.
>>> Maybe, it's a possible approach. As current patch set has no
>>> resources I feel we can leave this part to a patch on top
>>> just so that this one can move forward while we have
>>> a more specific example to work from.
>> we can differ the resources part but lets add the part that the group
>> becomes empty/non-empty according to the disable/enable of VF_enable
>> register as mentioned above.
> Hmm.  Another option is VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP when VF_enable
> is clear - since this disables the whole group not a specific member.
> This allows distinguishing between id > NumVFs and VF_enable == 0
> so it seems like a nicer option to me.
How to detect whether VF_enable set to 0 or 1, pulling is not a good 
idea, and do we want
SRIOV cap to notify the admin vq on changes?

Thanks
>
>
>>>
>>>
>>>>>>> So I would say we should just ask that VF Enable is set
>>>>>>> before poking at admin vq, and prohibit clearing VF Enable.
>>>>>>>
>>>>>> Sending admin commands shouldn't be restricted and should be allowed always.
>>>>>> Device should react to incoming command.
>>>>>>
>>>>>> We can say that an SR-IOV group is empty while the VF enable is unset and is
>>>>>> not empty when it's set. The size of the non empty SR-IOV group is equal to
>>>>>> the numVFs and the VF index is equal to the member identifier in this group.
>>>>>> I had this definition in my patches.
>>>>>>
>>>>>> Sending admin command to a non existing member will result in an ERROR
>>>>>> VIRTIO_ADMIN_STATUS_Q_INVALID_MEM.
>>>>>
>>>>> just an example:
>>>>> - assign resource X to VF 16
>>>>> - set NumVFs to 8
>>>>>
>>>>> Does VF 16 keep resource X? I note that
>>>>> resource X can not be taken back because VF 16
>>>>> is not accessible.
>>>> all dynamic resources should return to the owner when VF_enable moves 1 -->
>>>> 0
>>>
>>> It's a possible approach but my question would be whether we
>>> need a transport independent way to do this through VQ.
>>> And if we do it's annoying to have multiple ways.
>> We are defining the existence of the SR-IOV group.
>>
>> Also, the approach of sending commands to a non-existing member is valid for
>> any group type and should return error VIRTIO_ADMIN_STATUS_Q_INVALID_MEM in
>> that case.
>>
>> why do we need more ways ?
> Sorry I mean a transport independent way to destroy a group as a whole.
>
>
>>>>>
>>>>> For sure, all this is solvable but I'd rather just forbid
>>>>> changes to VF enable for now.
>>>> how we can forbid it ? setting this register is not related to virtio.
>>> We can ask driver to write 0 to device reset before changing VF
>>> enable to 0. The advantage is that this kind of reset by definition
>>> frees up all resources.
>> why do we need to reset the device ? It is fully functional and should be
>> able to run perfectly fine without any need to reset.
>>
>> The PF device might have a very big role in the hypervisor, so restricting
>> it in this way doesn't sounds mandatory.
>>
>> Controlling the SR-IOV group using SR-IOV register enable/disable and NumVFs
>> used as the number of the group size sounds simple from Spec and
>> implementation POV.
> Simple, however
> - only works for SRIOV
> - also limited, for example it's impossible to report an error
>
> I would rather not decide now until we have a use-case.
>
>
>>>
>>>>>
>>>>>>> There's also the concern of VF migration under MRIOV where VFs might
>>>>>>> not exit. I'm guessing
>>>>>>> trying to include that right now is overthinking. So maybe
>>>>>>> this should mention that VF Migration Capable should be clear.
>>>>>>>
>>>>>>>
>>>>>>> I will add all this to the spec.
>>>>>>>
>>>>>>>
>>>>>>>>         How about the converse?
>>>>>>>>
>>>>>>>>
>>>>>>>>                     Each device within a group has a unique identifier. This identifier
>>>>>>>>                     is the group member identifier.
>>>>>>>>
>>>>>>>>                     Note: one can argue both ways whether the new device group handling
>>>>>>>>                     functionality (this and following patches) is closer
>>>>>>>>                     to a new device type or a new transport type.
>>>>>>>>
>>>>>>>>                     However, I expect that we will add more features in the near future. To
>>>>>>>>                     facilitate this as much as possible of the text is located in the new
>>>>>>>>                     admin chapter.
>>>>>>>>
>>>>>>>>                     I did my best to minimize transport-specific text.
>>>>>>>>
>>>>>>>>                     Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>>>>>                     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>>>                     ---
>>>>>>>>                      admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>                      content.tex |  2 ++
>>>>>>>>                      2 files changed, 51 insertions(+)
>>>>>>>>                      create mode 100644 admin.tex
>>>>>>>>
>>>>>>>>                     diff --git a/admin.tex b/admin.tex
>>>>>>>>                     new file mode 100644
>>>>>>>>                     index 0000000..2bc7322
>>>>>>>>                     --- /dev/null
>>>>>>>>                     +++ b/admin.tex
>>>>>>>>                     @@ -0,0 +1,49 @@
>>>>>>>>                     +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
>>>>>>>>                     +
>>>>>>>>                     +It is occasionally useful to have a device control a group of
>>>>>>>>                     +other devices. Terminology used in such cases:
>>>>>>>>                     +
>>>>>>>>                     +\begin{description}
>>>>>>>>                     +\item[Device group]
>>>>>>>>                     +        or just group, includes zero or more devices.
>>>>>>>>                     +\item[Owner device]
>>>>>>>>                     +        or owner, the device controlling the group.
>>>>>>>>                     +\item[Member device]
>>>>>>>>                     +        a device within a group. The owner device itself is not
>>>>>>>>                     +       a member of the group.
>>>>>>>>                     +\item[Member identifier]
>>>>>>>>                     +        each member has this identifier, unique within the group
>>>>>>>>                     +       and used to address it through the owner device.
>>>>>>>>                     +\item[Group type identifier]
>>>>>>>>                     +       specifies what kind of member devices there are in a
>>>>>>>>                     +       group, how is the member identifier is interpreted
>>>>>>>>                     +       and what kind of control the owner has.
>>>>>>>>                     +       A given owner can control a single group of a given type,
>>>>>>>>                     +       thus the type and the owner together identify the group.
>>>>>>>>                     +       \footnote{Even though some group types only support
>>>>>>>>                     +                       specific transports, group type identifiers
>>>>>>>>                     +                       are global rather than transport-specific -
>>>>>>>>                     +                       we don't expect a flood of new group types.}
>>>>>>>>                     +\end{description}
>>>>>>>>                     +
>>>>>>>>                     +The following group types, and their identifiers, are currently specified):
>>>>>>>>                     +\begin{description}
>>>>>>>>                     +\item[SR-IOV group type (0x1)]
>>>>>>>>                     +This device group has a PCI Single Root I/O Virtualization
>>>>>>>>                     +(SR-IOV) physical function (PF) device as the owner and includes
>>>>>>>>                     +all its SR-IOV virtual functions (VFs) as members (see
>>>>>>>>                     +\hyperref[intro:PCIe]{[PCIe]}).
>>>>>>>>                     +
>>>>>>>>                     +The PF device itself is not a member of the group.
>>>>>>>>                     +
>>>>>>>>                     +The group type identifier for this group is 0x1.
>>>>>>>>                     +
>>>>>>>>                     +A member identifier for this group can have a value 0x1 to 0xFFFF
>>>>>>>>                     +and equals the SR-IOV VF number of the member device (see
>>>>>>>>                     +\hyperref[intro:PCIe]{[PCIe]}).
>>>>>>>>                     +
>>>>>>>>                     +Both owner and member devices for this group type use the Virtio
>>>>>>>>                     +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
>>>>>>>>                     +\end{description}
>>>>>>>>                     +
>>>>>>>>                     +
>>>>>>>>                     diff --git a/content.tex b/content.tex
>>>>>>>>                     index 0c2d917..ffe45c4 100644
>>>>>>>>                     --- a/content.tex
>>>>>>>>                     +++ b/content.tex
>>>>>>>>                     @@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>>>>>>>>                      types. It is RECOMMENDED that devices generate version 4
>>>>>>>>                      UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>>>>>>>
>>>>>>>>                     +\input{admin.tex}
>>>>>>>>                     +
>>>>>>>>                      \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>>>>>>>>
>>>>>>>>                      We start with an overview of device initialization, then expand on the
>>>>>>>>
>>>>>>>>                 --
>>>>>>>>                 Tell her I'll be waiting, in the usual place.
>>>>>>>>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

