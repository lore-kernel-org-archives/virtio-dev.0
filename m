Return-Path: <virtio-dev-return-11782-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7B1C6FD1D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 14:57:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 153D87C2EC
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 14:57:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BAD2986318
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 14:57:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F3AB8986293; Mon, 27 Mar 2023 14:57:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF24F9862A8;
	Mon, 27 Mar 2023 14:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4fHwfG6ISKqntw2YG923D3yMAwwaVe7ZJkrqaknssIcYnY1ARmkJTtwAnwicl68vhy8PFtULpGDMB8REwsUtlmdZOKMwEq5EVM6bpe4TBjtMsY+Jb6lUUwmlq1Ee1B2/hsAV6RFx8z6wfj3Inskc24mOQpruZKPx0DetsVhas8ywSNzR9qqSbOHSVUlGnuHzwtYbfs7W3UpqDoRbcWKD/cok3KDsIdFgqY2rZ8jVR8GgxMFIXIjAqtRh4QQFpDsdxTbN5SAiD4ZNdrS6ZtzmTF/UJSLGQwFsL3PDdGF+vCMx/cgkImHEb2E2gwXgo/tLuewMAUe1772PyFpccV1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfRIoA40R8GXm0rKEwbX+vJhLIEaQvIbOSB2aWP/gWE=;
 b=WYLza8bYwxkIu7TpNh/5FG8u5PyxFnpJJ4QGMYIn7Jod+Ee2jjXvjxvjbYsWFJiFOo90fd5PAKW/h0aeW5Tsi2YuN2j1vdFXIe+foARd5pehZ9xt5lZvMdOGXF1pB6zNwZHU2L5/5s+LzmiXC634sEKmyqynVvXpBBGhAFImxfBYunmsdljVuHZmyeC4PTi6dqw0WYxfY6Qf5ewbrYvcdC/qWy8T0OlszsDz1SYNJnP4p2m8MHA4x+Lg4LWEASf0q2OWrrAM8Z4MTsofYXf3MMxQAERXxrRrE/dKctnvRa5XK/oTY2x1TYRFXvmoTqeetCiB5OJ0MUnump5c7dyB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com,
        cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
        Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230324013534.280820-2-parav@nvidia.com>
References: <20230324013534.280820-1-parav@nvidia.com>
 <20230324013534.280820-2-parav@nvidia.com>
Date: Mon, 27 Mar 2023 15:57:21 +0100
Message-ID: <m2sfdqckdq.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::30) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|MW4PR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: cffcda97-3768-4225-c813-08db2ed394d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/Q2ZgCDt2fM5IoU6xSUvBE5QdWnQnDF+8ZN3CGx6fVc7kNxMp5R5t04mSlVG2RJg5eDOKTvubwZ/YgepCJbkw3PXcyPSxN70YSTpEzOgJnrEAseY6JnObD17jbzKipCAdm81Vyb50/01VHFXtzOh7RGyEGZn2H2kB53sJE+yhtaGjPcFX4frGLG5plXgts6iNlEYgTb0ZzGYamsTCGsZUghm+hURkSgACIgmqFUzYZdHM6hv3urfpHaJro6vBzNch8vMsyCWM3LpSaB+R4ge5C/G35mvSotGxvYohIcOmWF2XCMm8ax9SX6IKQu1skojV8aNPmhuIpl9qCfjGf3dSklkgwGXHA+wLuUeCA+RSwMaRpg9iyU7SAgKNe4x/4nFDbSBQyG2Y9DqHwJsAzVVpYRTiqq8NW3XZF39T1IhDXrDVn8ztI/pcG5aWmqkT0ErQkSCo3Ow82/+vRkPA4yzyCCLbmJYOy/I3kq/Mi46hB5xvUxMm18go/5E7bqde42s30LNtGv+UNxScG+loVJ/4qUcGH+6uFcCyEtwp8+rR3KHf8Gdl/Weg7vmXv004THavjVC2CtsNnD6CTrLUdi4XQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(36756003)(66899021)(86362001)(478600001)(316002)(8676002)(66476007)(4326008)(66556008)(41300700001)(66946007)(6506007)(6512007)(26005)(6666004)(2616005)(186003)(83380400001)(6486002)(966005)(2906002)(5660300002)(8936002)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VBcfPaVcjZjPFBuhG8a+wIhB5jx1zbrISI6Y0q1BmJ4KBaLXqGl2TUQTpOEK?=
 =?us-ascii?Q?YSpgT5xei1ic11vlE27rApR2NCQTWBeTY69YAtAm3GLWVcWgtodUOilivuh9?=
 =?us-ascii?Q?LBFxbz/fh9OixTK8fzZUgC0ciim4AnfXiQfdA2ZzJsH+sP9nlsaviLDf9S/I?=
 =?us-ascii?Q?pLaXpT8Gvwc6Nh8fJSz/5B3hiihLP0OUYKIqNIWAflAzoq+SNmz6z2+sU7ap?=
 =?us-ascii?Q?GiVSvsCqZfZZkO58dmqd3OcPslyGQXDfwRzel662+yBrhh6Hx1/egEdU93Tc?=
 =?us-ascii?Q?SdefMeEynQK3tXsiQHf/8vSyYg355JrsvyPBBKQuM70visSWpGpGXq8dupm+?=
 =?us-ascii?Q?TgtVSrk6uRUh4daocNXxr+1FBrAmr9x0iFxSnCktcuFn/qlqDr5t7y8kP17g?=
 =?us-ascii?Q?YxNsmsk0gp10tbHApSXW/gLOP+rkqRrSJrYqlcNNOgw/brMhIV1JRWgSdJ/B?=
 =?us-ascii?Q?AwGrELNTNoj0XrdcyLKT7PonvCP9wje2rqpphXgdlpzZwqHfDrBJzuXoJyjm?=
 =?us-ascii?Q?fbrhor0mSHahnKYt8NLNOQ3MiR+6EvL2ayabhwu6N/UWpMp1Y+xFhd7GK9E+?=
 =?us-ascii?Q?up4mmsH7DbjLZowjCNd/uI9Bn3PqHIQOb+O18CXW9r4Hi4kNHG7lF/y8ze2S?=
 =?us-ascii?Q?mphStmiKviInAXE3f6jBjWcAWWJ7PQI2fYx3niAwgPfwzA8fWcDZ5PVKQObZ?=
 =?us-ascii?Q?dJ0T4T6hpOwP/JRxiSIfQs9//g2tJeST+42kX3r4+UNrfTENIehKYJtAK7A+?=
 =?us-ascii?Q?Q1ZgBUHshq7wpJUwSlG/OztDUsSimPweBksKZYsdcFbpYnobOBnNT3jkpLYF?=
 =?us-ascii?Q?RWT72XnxowB5lUaUbu2cOadRlNprU+1r4uEenV8mdlt5Gty9hdKceA+lknNZ?=
 =?us-ascii?Q?os+Ih5ITxYogrUrhq6iRuxIZJ02feaYVfVhrJFj0ai9UK4/rdwOxrx0+0Vht?=
 =?us-ascii?Q?PGP3NdCmNtZTSmZOeasRdrLgXqXpVS2qbVXoSEjvAr5/BUXo4nMw2FGJTs7B?=
 =?us-ascii?Q?jbE8Hyaf2YtaVo87q41vMBv5unOoO3OGnZF8F6FkPLZd+pQZYRdzIz2bYAOK?=
 =?us-ascii?Q?26bqIunAFv0lLrRiPnbZJg5wp5Jz9eX0oCjkR7+wypm+WOO/li7HbU/RBzTj?=
 =?us-ascii?Q?n6GXqDhyjt4dDGlCjnxJfqbv3pestkm//5ao373CszC++oQMlEJEA3O2l4Se?=
 =?us-ascii?Q?eG0dEV0VGRD7+h5tu+s+9GQxRND/tKBqw2KhNnSz3Alq/UEj7tctda3Qn6cc?=
 =?us-ascii?Q?gqO0nqqWN6MzPYKDbjc+WdDerWhY9b8pMOb129cIyeV0jxXF/Dhgzcgq+1nJ?=
 =?us-ascii?Q?RkHxTCdYhrNEenXr41XDl4+2FgPGSeNIZJQGSbJWQOOgA+m4Cx1ZGJMIdSgE?=
 =?us-ascii?Q?N8haSojgmC4f7GSJcUItyvM754cFm7sDNJaQ0ZIC9e5faJVHHQ/s8fAVZdVK?=
 =?us-ascii?Q?TliNW+MPqlXumc8B8AwkcQccMVWxCMprkgRRXkQGeifsxMhnf3c4wE0Zu9WR?=
 =?us-ascii?Q?7Nvaa9UPBSjeptsrcS8nD2CUHmV8mIjAQv8Sx2fPj/41Fpx8z2QqUi1/12Cv?=
 =?us-ascii?Q?NW+WR/s5qd4Oah50LReuLjNMenKtIW/MDdBIABsmQVfgElSkjKjByTbO5Qw3?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AMZ2VXWMPFVHpwsz8WofnP/lcbvaMcdV7eOWaLSn1dTAp9057LPoFqgy1Af1DjczWm0N0FiCuAG37YSnY0BEId+FuGLIdcQ8pFK2z4rCbv1bNqZpXREgaL16v2kxs1m6hKNJiUEmYX6qXPkzkg9roIlhIcHiYPrbLr0JuJPAM1XExafqmffYkR7/kxrqPkAzdGwtG5YWxFtBkE5eaYuUcVAbrwTlZ/DgaaC170KmivVqA7DwvH2KGEoxytCKvD1FPzfnMN7/p3IDTNHJFaUmdf6bS49x0ii9i1FxaOBgv4BvVTY5aM6lYg2o8U02HCPlCM+qpPl3VFoZl3Lt7dSNH4R4LaoQECyGluKz5YpX41VluCyhafAS/PnU57v+mQICFLeaJ/g6F3c+vR+kKLg3cEi+mQ0Ivvl5uFui7Erd1bcpZ95erb7+Lb7HGsOI4jawy5VK+/KxRLl2HdGaF65A4cOdJ861aeRlLFN6cHcarVvWCHr9bVOlxB5QYXTGf0V8U6cQRFAtE4OFkd11kFzTUlamcBkiQ88zD29/KoHFKwejbqRw1Tn+LfaER9lIMZrPvNgd92sXKgKSjvw0sQSUwSuohI+hm9w6puzHODqM+R84DQCwm3CBCyPotqpaADOL48c6kwmJVCjb9AF7AK1rOGR3Rb3cQeQEL/HpWSZ8Hk5Z3acQ/a+zZYOkV3Hxb6D+l3EFN3CypAwOu2Nnk/FsGodqvp9tmcRaFUZYhaWSvA0M0rxM/Dd0CceqK9qjP7IdR6mkfw4FNGwGdW0DN/qohnFzm022tTEZ0z1smUsKK8xMWV0uVWD041W44F4iHnt2CXztIqKxG0wM1pAogSFFnGnlYTIfLpHq/64q5Y3kUz+dt/01Tp204nlCeh02IpfJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffcda97-3768-4225-c813-08db2ed394d4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:57:27.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OS+82HRdvxvKn9l8IlKzIgiktqCmmOnUto+6pWvEMOXSF/VwOrmoLo8qcxF6mfiVCITL0v/S6EA564zxAv9qol0giCCW2uhdqo0vdaZisME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270118
X-Proofpoint-GUID: VoZNkbm45iNWIe-Z7NOEWIIKmtvjcSlc
X-Proofpoint-ORIG-GUID: VoZNkbm45iNWIe-Z7NOEWIIKmtvjcSlc
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 1/3] transport-pci: Remove empty line
 at end of file

Parav Pandit <parav@nvidia.com> writes:

> Remove empty line at end of file.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  transport-pci.tex | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 044c085..6e0cb45 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -1148,4 +1148,3 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>          re-examine the configuration space to see what changed.
>      \end{itemize}
>  \end{itemize}
> -
> -- 
> 2.26.2
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
You bring light in.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

