Return-Path: <virtio-dev-return-11475-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD06C678DB
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 11:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 85451776C3
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 11:05:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C02A9867B5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 11:05:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B9B239866C7; Tue,  7 Mar 2023 11:05:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C3C79866C2;
	Tue,  7 Mar 2023 11:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZMTFocKCRXL6Tu1ceyATZ/RGFyOQ5FGU6ebyTWbbQ85W0JbFLaBb1e78h3nNKJg1UaiAS+m6d2ARzHklFnrwieFvtKzbIMhuCbFj9KaHEjJDM+uhpjUVPjyqLni2beqCTBdRMJfBIIgjSAHk0flTLFd5DhXODEUOWNH5Mr/ZQjeQ2gpfYifJuHHBhaFBldGY2oJz3pkY4JcyayWCsfAeL3h2vVldS5AWoXuosLyR4FiaGxcP6/sgtoEssQH3Jq93z2b7yx+BkHCp5O3pw367ONxlo7ZyYZ55oFGuJ4VccYM4h2EyHJbqmzcPenz6sViJg0I7RRf0+tXU038ued2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nAHX/rf2yjOII7GIyJiNuQ6AVyNoPrpPYqRkQeA6Cw=;
 b=NClHgGE39cCcJ9IsBkHrNOZpXn41G8fMuW19/1BqoAkAPFID0xWHhOO1iifye5ZBASsJppL2+ohpz1FNVqRUa9p9/BSjixO0hO+a46t3l27HBlLYuuQW4LGnU963R94GhN18Fgjq7r7Z05uONyXoT58bSYg5ircxw+6fvwpQQYVclHmcEjd74Tqt0R83mn+zgkVRXFW0WAZ87C+acA6N8FTLo8JhcdE0VXckfZCbRPunjQ0l3bh5rGYDK+Plus+WyJpg1MLk2fXLIe3HL1tvJfHoocsGQdRUuOo+FhYoo+wN4BvWtZvxnHFdtvKiolQb9fEa7IpiObSbttfRnUsmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com,
        cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
        nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
        pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
        Parav Pandit
 <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
Date: Tue, 07 Mar 2023 11:04:33 +0000
Message-ID: <m27cvszuta.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|PH0PR10MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3effa832-b183-40a2-8993-08db1efbbf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r/6RESTZxtvD2UEN1y3DgXnh8lDA3idaoS22zEE2fKwp4zvYGSYmKeJ3aE0guk/J41RboSX1CHEr5CR70RxvjbSr4W/GohEZ63+HTVlsVf+GI9wUMArc3Xlj5U0cKbzCs4OUytQVQzhLeMs29snCyHfl7816jzm11SjdN9Pd1SOye1c5Nw4K62BvrFvJGqeGk+hy1doOgkzs38Pi8R/z0UMREviETr/UwV5C0IwVwfeS4wPKbcEBVSajgEkUzVhd+AC8ohnekD9sYyiQNuQaCr7vT03GyXWuVjrpZzdlT9oYuB+n5cgdgGIvQg04SFZJhCNrZW7WtcArHj5hFzwNGe43Vt7lAXcMPzI6e5vvk3v1HOu4eANNMbjeip9/xv86F0tRxQ6BxI5faoTHiNO2wGF98Sqz3E4Kg/k1U35rSAH4Pi9jWXHRrzsxgEEnsfnscbN+PPrl0ZDmmHpOBjUrqlscIeobRSj7iAK4P2we3mzV6rdxxMIs0aeZ3uKetNYuMvMsHN6EbqE1K8wa195F/Y8/fwdkbkv4dkJG4MsVkfYfF60dDdkAkH33aN6b/scq90vl5OHRGlOzE2YeVm0hkcnBYc4AdhiUAbgv1PNSiBPBVOepU2pD+VGHhjE9elk5qKKS8OdRIdHSHQSLGeYnqutsAh4ad3ZCiQXpwWTE351KzitZFjmWVZ/W4vVTS6o6+QFwN0dMbzAMGE3VAvaZVg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199018)(36756003)(54906003)(316002)(478600001)(83380400001)(6486002)(966005)(2616005)(6666004)(30864003)(6506007)(26005)(6512007)(921005)(86362001)(5660300002)(8936002)(41300700001)(66476007)(7416002)(66556008)(66946007)(2906002)(8676002)(38100700002)(4326008)(186003)(44832011)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gMzx6zLYrLTgSjSBvqvvDHdU7g8VGQrO0ZQb2lECmwjaq6LC7bhRX4TFV8Vw?=
 =?us-ascii?Q?hV6WYcYIkhTSKYgjYEo6RwMwv1pRp7HRwaLpVEoSbLi9p04ZMoomLkASRC9Z?=
 =?us-ascii?Q?MM43RFeESnVGYZHWO/2ioar2a4JUNrQ9IWCq/xD/Kw/EYV0YT3oQKSjsud3L?=
 =?us-ascii?Q?Zbef0M9RKeZ+h94QHB0BUDUCSuCI6T87cMdMtW0nKg1IG+bvEw8GjIcOTmlV?=
 =?us-ascii?Q?TA2aB2182HBZ24602VF+yjPJaUUJ1PXbLXyvlfe9QQfmP5BPiNzod06a0DqM?=
 =?us-ascii?Q?5RvDUru/aZL5GC32CBscvO0vumQrVSxtN2Ppbg79lmsJJT3TqkYk/QBtKa/V?=
 =?us-ascii?Q?YE/uWfHpIG3bTap9elHeO+vu1L5s//8dy+3nH9Y72i647V6Usqu+VfcqKGf/?=
 =?us-ascii?Q?FLIIhCFOs+SWmc6b9Kd8IvpjAZGBI/L5vWZjaWqiJ4eSdk+h2CDkih5w6PGt?=
 =?us-ascii?Q?6dSfALtkVx40UGuzR2MYmUar7LRny7joReUkh/XMIIiStoNLLOOmiO56+PLO?=
 =?us-ascii?Q?UTdkC/4TSOtEV74/INFEgs5wIse7k3VMPCpkWvr9uY7mb/jcrWxtc25f5iX7?=
 =?us-ascii?Q?GoW5hAxZDzlEtVBd6CBfxpA03LgmQMrL/X5igcqu0APvquK7wVF2yA7DS0f/?=
 =?us-ascii?Q?0DMCkHwYwlFl4Y3ilTUhSTxyCnbx0tVeP2xWPj8ne+OPGwfb8h/mqkrZxkR9?=
 =?us-ascii?Q?criDB6A5us8EDpeOwHxH5afXAJQeyzJ1w9ud8QwJflGfiVUPW2ZQZJF8XNBm?=
 =?us-ascii?Q?VQ8qGbd5iR2Z7pFDVw7Mdnqxg9CaurJBqJAxpslkiYbd8v0EsKzGe/IY1fSQ?=
 =?us-ascii?Q?hYKPv2R+45XrBFrg34jTmNPd12s7JFo5i5XXPMDK+mH0W3VykjwXFuNu6Qpn?=
 =?us-ascii?Q?dFhuDS+qJqORKVlF1J2wb7mSauhfwMkPEUJxHf61+T34nvMvoZsyYeRTJk9x?=
 =?us-ascii?Q?kHSrbmGe/6kmn1qMjJ7BX5qxfW9jIkzyt74b45MHJj+AY4CF/G3rNG7fcOBw?=
 =?us-ascii?Q?UTeLzqVYPleNm1z5cxL51AkQmGaIeMTkwMV2l16SxU9gcyYtqO4mvTABk3Bw?=
 =?us-ascii?Q?ktJbSIVm8oFqhElNO9Rlx6XkjIewrF34N/XrJfD3tL7CCRm70ckVQacDzK/M?=
 =?us-ascii?Q?ZwO3CPQiiLY0M1okwbfgYutRcIfZErrEHDB15MCCseT82ww3L/ftQCDWIt7d?=
 =?us-ascii?Q?8oRyyZm21Va/Z4B8i2+2KxznzErW1nhlh0+C+9P4ZQqj0h5NKzQ3bn8V4NBm?=
 =?us-ascii?Q?39mMdJX4up/HEPY2ICWZLS8jJeUVlHkaFJg/MTDm9hSAYBD1WzYQ5tkmDHx9?=
 =?us-ascii?Q?lV2khPx855o+lJRy7P/B2TrTqlh6gqlSOIBW1C8BdnMEEbszfgrtkxzxTAwM?=
 =?us-ascii?Q?Cb7z7cot1epgI+bjqNlJ3pBfVcGgAa8BNji0CgZMFxPJKezKwMUShikqkSv4?=
 =?us-ascii?Q?Egs8T5Gfeb36KZzBVYWLRaNi9H4z4/CfXtTU6d0eQNsEw/rMfMAakpZfm5ye?=
 =?us-ascii?Q?v5PvyixbMgm0IeZqvVZeYlm2R9dP/aYbdihe6LIpcwS2x/HkjcxUx4Q6PsHe?=
 =?us-ascii?Q?fe9fXHYgObx1sO2jh8mmUZYoMG6cOc27posmIJN8QAnd+gxqn60r/lPkW8XZ?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q1k8xmHPKB3GCPSKHkg06n33rFPV9T2vBfi97PanUrb9YvN+jSCiTQbSRfeB48DPZVqXQv1LN6SvIgeCRPW3OHbQP9hX9w/ncYFOuLdDq8LtsZ3aGl2uErIB8Wi8wFxGe1sUplWsxVNswQwt0zJ7KeAELQWzG20FJN4DZzIFxbCXenVTyFgssVzvVbCgko+vCRs9cuxqNHJjroBEwGD0vC0k5SgzASNkrKnT1ajo4+lq/N6DoYOhTBxX9ewXPB2L2yCf+3MbJPNYftKzMdkBW6WdWWk/GwZ5CK8QgnhUFB9iAAS9tcw55wnsWBIOS84RFDyNHKLP74uJirHsd8g20sy2epjBUn+l3IqqSYVv86iBG1LbhgAbpJ01bfoBmkCxB2vsPIsZGk+HpiVcD56Ea45wplbYEtZKefl9SNItyOBUZQjcYhDvGi2QcUyp5eyc7RDA+2zwTyq32/uYQ1SDDq3AYgIrPGTiB/Kj+d5HwjPFuBb3FBg9x9RaJ5b6q93O/W95SmxD0QgAb+V7jpufCvpUHW6hIWkO3PQWeAduQpytdgiYhbIi+bsdHeZmgj3WPP1F/sdvKrpKhqJhp+bo7Ygbd2sVqBSfqpYv3mBsB28o+SlWqvhTnCG6V9Hd5u1jPlt5quzSxGG66IhwlYrD16B6eBBZ9Cmy+ecZgBSfl/71wNQT2DvcDEAHKo2AtSCunZf8EPRqEJsjuk6HM6PUauLTjHAMSfUflnlZnC2cb/+ygKPrtnMCbOb2lroqUu2IH43HopK8fjHZP0mn447JMVlvKoVLnpkmE3RcHZSaW1p81vQYx438Qzk4oJC0mxRSufWfGSGhD6YZRm/05nsUEIxw7S6i2BvuOJ82PxZ3HpEd9peBnFWjjjz1pEFuvGfE6SyH/6PZilBGrF9OgrPwOw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3effa832-b183-40a2-8993-08db1efbbf73
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:04:40.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10rK85KZ58fqw24Y+iCAb2rlky1NoR/OyxexmVprToJEoU7N4uwieHRvqpBr1l2xP/sivnUjfEfKZ0qyushSRYX33ei+nb0CWzch/4yKll4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070100
X-Proofpoint-GUID: pZutX5WBfU4QJNtxiIG1Xemc1m8r8Pbo
X-Proofpoint-ORIG-GUID: pZutX5WBfU4QJNtxiIG1Xemc1m8r8Pbo
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 09/10] admin: conformance clauses

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Add conformance clauses for admin commands and admin virtqueues.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 215 insertions(+), 1 deletion(-)
>
> diff --git a/admin.tex b/admin.tex
> index 1172054..6c4f79c 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -251,6 +251,145 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  supporting multiple group types, the list of supported commands
>  might differ between different group types.
>  
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> +
> +The device MUST validate \field{opcode}, \field{group_type} and
> +\field{group_member_id}, and if any of these has an invalid or
> +unsupported value, set \field{status} to
> +VIRTIO_ADMIN_STATUS_EINVAL and set \field{status_qualifier}
> +accordingly:
> +\begin{itemize}
> +\item if \field{group_type} is invalid, \field{status_qualifier}
> +	MUST be set to VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP;
> +\item otherwise, if \field{opcode} is invalid,
> +	\field{status_qualifier} MUST be set to
> +	VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE;
> +\item otherwise, if \field{group_member_id} is used by the
> +	specific command and is invalid, \field{status_qualifier} MUST be
> +	set to VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER.
> +\end{itemize}
> +
> +If a command completes successfully, the device MUST set
> +\field{status} to VIRTIO_ADMIN_STATUS_OK.
> +
> +If a command fails, the device MUST set
> +\field{status} to a value different from VIRTIO_ADMIN_STATUS_OK.
> +
> +If \field{status} is set to VIRTIO_ADMIN_STATUS_EINVAL, the
> +device state MUST NOT change, that is the command MUST NOT have
> +any side effects on the device, in particular the device MUST not

MUST NOT

> +enter an error state as a result of this command.
> +
> +If a command fails, the device state generally SHOULD NOT change,
> +as far as possible.
> +
> +The device MAY enforce additional restrictions and dependencies on
> +opcodes used by the driver and MAY fail the command
> +VIRTIO_ADMIN_CMD_LIST_USE with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> +and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD
> +if the list of commands used violate internal device dependencies.
> +
> +If the device supports multiple group types, commands for each group
> +type MUST operate independently of each other, in particular,
> +the device MAY return different results for VIRTIO_ADMIN_CMD_LIST_QUERY
> +for different group types.
> +
> +After reset, if the device supports a given group type
> +and before receiving VIRTIO_ADMIN_CMD_LIST_USE for this group type
> +the device MUST assume
> +that the list of legal commands used by the driver consists of
> +the two commands VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +After completing VIRTIO_ADMIN_CMD_LIST_USE successfully,
> +the device MUST set the list of legal commands used by the driver
> +to the one supplied in \field{command_specific_data}.
> +
> +The device MUST set the list of legal commands used by the driver
> +to the one supplied in VIRTIO_ADMIN_CMD_LIST_USE.

Are these last two paragraphs not saying the same thing?

> +The device MUST validate commands against the list used by
> +the driver and MUST fail any commands not in the list with
> +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> +and \field{status_qualifier} set to
> +VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE.
> +
> +The list of supported commands MUST NOT shrink (but MAY expand):
> +after reporting a given command as supported through
> +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
> +as unsupported.  Further, after a given set of commands has been
> +used (via a successful VIRTIO_ADMIN_CMD_LIST_USE), then after a
> +device or system reset the device SHOULD complete successfully
> +any following calls to VIRTIO_ADMIN_CMD_LIST_USE with the same
> +list of commands; if this command VIRTIO_ADMIN_CMD_LIST_USE fails
> +after a device or system reset, the device MUST not fail it
> +solely because of the command list used.  Failure to do so would
> +interfere with resuming from suspend and error recovery.
> +
> +When processing a command with the SR-IOV group type,
> +if the device does not have an SR-IOV Extended Capability or
> +if \field{VF Enable} is clear
> +then the device MUST fail all commands with
> +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
> +\field{status_qualifier} set to
> +VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP;
> +otherwise, if \field{group_member_id} is not
> +between $1$ and \field{NumVFs} inclusive,
> +the device MUST fail all commands with
> +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
> +\field{status_qualifier} set to
> +VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER;
> +\field{NumVFs}, \field{VF Migration Capable}  and
> +\field{VF Enable} refer to registers within the SR-IOV Extended
> +Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> +
> +The driver MAY discover whether device supports a specific group type
> +by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
> +\field{group_type}.
> +
> +The driver MUST issue VIRTIO_ADMIN_CMD_LIST_USE
> +and wait for it to be completed with status
> +VIRTIO_ADMIN_STATUS_OK before issuing any commands
> +(except for the initial VIRTIO_ADMIN_CMD_LIST_QUERY
> +and VIRTIO_ADMIN_CMD_LIST_USE).
> +
> +The driver SHOULD NOT set bits in device_admin_cmds
> +if it is not familiar with how the command opcode
> +is used, as dependencies between command opcodes might exist.
> +
> +The driver MUST NOT request (via VIRTIO_ADMIN_CMD_LIST_USE)
> +the use of any commands not previously reported as
> +supported for the same group type by VIRTIO_ADMIN_CMD_LIST_QUERY.
> +
> +The driver MUST NOT use any commands for a given group type
> +before sending VIRTIO_ADMIN_CMD_LIST_USE with the correct
> +list of command opcodes and group type.
> +
> +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
> +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
> +with respective bits cleared in \field{command_specific_data}.

This runs contrary to the assertion "The list of supported commands MUST
NOT shrink", given that a driver is told to assume that
VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE are the only
commands initially available.

> +The driver MUST handle a command error with a reserved \field{status}
> +value in the same way as \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> +(except possibly for different error reporting/diagnostic messages).
> +
> +The driver MUST handle a command error with a reserved
> +\field{status_qualifier} value in the same way as
> +\field{status_qualifier} set to
> +VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND (except possibly for
> +different error reporting/diagnostic messages).
> +
> +When sending commands with the SR-IOV group type,
> +the driver specify a value for \field{group_member_id}
> +between $1$ and \field{NumVFs} inclusive,
> +the driver MUST also make sure that as long as any such command
> +is outstanding, \field{VF Migration Capable} is clear and
> +\field{VF Enable} is set;
> +\field{NumVFs}, \field{VF Migration Capable}  and
> +\field{VF Enable} refer to registers within the SR-IOV Extended
> +Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> +
>  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>  
>  An administration virtqueue of an owner device is used to submit
> @@ -323,4 +462,79 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
>  of the specification are designed, new fields can be added to the
>  tail of a structure, with the driver/device using the full
>  structure without concern for versioning.
> ->>>>>>> 0edc690... admin: introduce virtio admin virtqueues

Oh, here is where it got removed :-)

> +
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> +
> +The device MUST support device-readable and device-writeable buffers
> +shorter than described in this specification, by
> +\begin{enumerate}
> +\item acting as if any data that would be read outside the
> +device-readable buffers is set to zero, and
> +\item discarding data that would be written outside the
> +specified device-writeable buffers.
> +\end{enumerate}
> +
> +The device MUST support device-readable and device-writeable buffers
> +longer than described in this specification, by
> +\begin{enumerate}
> +\item ignoring any data in device-readable buffers outside
> +the expected length, and
> +\item only writing the expected structure to the device-writeable
> +buffers, ignoring any extra buffers, and reporting the
> +actual length of data written, in bytes,
> +as buffer used length.
> +\end{enumerate}
> +
> +The device SHOULD initialize the device-writeable buffer
> +up to the length of the structure described by this specification or
> +the length of the buffer supplied by the driver (even if the buffer is
> +all set to zero), whichever is shorter.
> +
> +The device MUST NOT fail a command solely because the buffers
> +provided are shorter or longer than described in this
> +specification.
> +
> +The device MUST initialize the device-writeable part of
> +\field{struct virtio_admin_cmd} that is a multiple of 64 bit in
> +size.
> +
> +The device MUST initialize \field{status} in \field{struct
> +virtio_admin_cmd}.
> +
> +The device MUST process commands on a given administration virtqueue
> +in the order in which they are queued.
> +
> +If multiple administration virtqueues have been configured,
> +device MAY process commands on distinct virtqueues with
> +no order constraints.
> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> +
> +The driver MAY supply device-readable or device-writeable parts
> +of \field{struct virtio_admin_cmd} that are longer than described in
> +this specification.
> +
> +The driver SHOULD supply device-readable part of
> +\field{struct virtio_admin_cmd} that is at least as
> +large as the structure described by this specification
> +(even if the structure is all set to zero).
> +
> +The driver MUST supply both device-readable or device-writeable parts
> +of \field{struct virtio_admin_cmd} that are a multiple of 64 bit
> +in length.

This addresses my question on a previous patch.

> +The device MUST supply both device-readable or device-writeable parts
> +of \field{struct virtio_admin_cmd} that are larger than zero in
> +length. However, \field{command_specific_data} and
> +\field{command_specific_result} MAY be zero in length, unless
> +specified otherwise for the command.
> +
> +The driver MUST NOT assume that the device will initialize the whole
> +device-writeable part of \field{struct virtio_admin_cmd} as described in the specification; instead,
> +the driver MUST act as if the structure
> +outside the part of the buffer used by the device
> +is set to zero.
> +
> +If multiple administration virtqueues have been configured,
> +the driver MUST ensure ordering for commands
> +placed on different administration virtqueues.
> -- 
> MST
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
-- 
Music has magic, it's good clear syncopation.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

